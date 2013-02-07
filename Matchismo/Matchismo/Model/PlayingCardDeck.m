//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by  on 2/3/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(id) init{
    
    self = [super init];
    
    if(self){
        for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
            for (NSString *suit in [PlayingCard validSuits]) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card atTop:YES];
                //NSLog(@"I'm here PlayingCardDeck init()");
            }
        }
    }
    
    return self;
}

@end
