//
//  Deck.m
//  Matchismo
//
//  Created by  on 2/3/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *) cards
{
    if(! _cards)  // If not already allocated/initialized
        _cards = [[NSMutableArray alloc] init]; // Lazy initialization on request
    return _cards;
}

- (void) addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop)
        [self.cards insertObject:card atIndex:0];
    else
        [self.cards addObject:card];
}

- (Card *) drawRandomCard
{
    Card * card = nil;
    
    if(self.cards.count)
    {
        unsigned index = arc4random() % self.cards.count;
        card = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return card;
}

@end
