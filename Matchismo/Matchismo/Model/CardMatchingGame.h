//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by  on 2/5/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id) initWithCardCount: (NSUInteger) count
               usingDeck: (Deck *) deck
            withGameMode: (int) gameMode;

- (void) flipCardAtIndex: (NSUInteger) index;

- (Card *) cardAtIndex:(NSUInteger) index;

@property (readonly, nonatomic) int score;

@end
