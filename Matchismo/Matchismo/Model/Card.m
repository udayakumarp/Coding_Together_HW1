//
//  Card.m
//  Matchismo
//
//  Created by  on 2/3/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card * card in otherCards){
        if([self.contents isEqualToString:card.contents]){
            score = 1;
            break;
        }
    }
    
    return score;
}

@end
