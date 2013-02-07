//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by  on 2/5/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (nonatomic) NSMutableArray *cards; //of Card
@property (nonatomic) NSString *description; //of last action
@property (nonatomic) int gameMode;          //Simple integer will do
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
    if(!_cards)
        _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (id) initWithCardCount: (NSUInteger) count
               usingDeck: (Deck *) deck
            withGameMode: (int) gameMode{
    
    self = [super init];
    
    if(self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }
            else{
                self = nil;
                break;
            }
        }
        self.gameMode = gameMode;   //Default game mode (2 card draw)
        NSLog(@"Game Mode = %d", self.gameMode);
    }
    return self;
}


- (Card *) cardAtIndex:(NSUInteger) index{
    //NSLog(@"Received index : %d", index);
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex: (NSUInteger) index
{
    Card *card = [self cardAtIndex:index];
    if(card && !card.unplayable){
        if(!card.isFaceUp){
            self.description = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            for (Card *otherCard in self.cards) {

                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.description = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    }
                    else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.description = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
