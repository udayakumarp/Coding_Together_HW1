//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Udayakumar Pandurangan on 2/3/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionDescriptionLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) UIImage *backGroundImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentControl;
@end

@implementation CardGameViewController


- (CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc]init]
                                               withGameMode:[self getGameModeSelected]];          // Deafult game mode 2
        
        NSLog(@"I'm @ CardMatchingGame (_game) lazy init");
    }
    return _game;
}

- (UIImage *) backGroundImage{
    if(!_backGroundImage)
      _backGroundImage = [UIImage imageNamed:@"CardBackground.jpg"];
    return _backGroundImage;
}

- (int) getGameModeSelected {
    int gameMode = 2;  //Default
    
    if([self.gameModeSegmentControl selectedSegmentIndex] == 0){
        gameMode = 2;
    }
    else if ([self.gameModeSegmentControl selectedSegmentIndex] == 1){
        gameMode = 3;
    }
    return gameMode;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI{
    for (UIButton *cardButton in self.cardButtons) {

        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        // Need to set the background image only for the NORMAL state 
        //[cardButton setBackgroundImage:self.backGroundImage forState:UIControlStateNormal];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.actionDescriptionLabel.text = [NSString stringWithFormat:@"%@", self.game.description];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void) setFlipsCount:(int) flipsCount
{
    _flipsCount = flipsCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipsCount++;
    [self updateUI];
    if([self.gameModeSegmentControl isUserInteractionEnabled]){
        [self.gameModeSegmentControl setUserInteractionEnabled:NO];
        self.gameModeSegmentControl.alpha = 0.3;
    }
}

- (IBAction)dealNewGame:(id)sender {
    self.game = nil;
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc]init]
                                               withGameMode:[self getGameModeSelected]];
    [self updateUI];
    self.actionDescriptionLabel.text = [NSString stringWithFormat:@"%@", @"Game Reset!"];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", 0];
    self.flipsCount = 0;
    
    // Re-enable and alpha setback for user selection
    [self.gameModeSegmentControl setUserInteractionEnabled:YES];
    self.gameModeSegmentControl.alpha = 1.0;
    
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    // Something needs to be filled up here.
}


@end
