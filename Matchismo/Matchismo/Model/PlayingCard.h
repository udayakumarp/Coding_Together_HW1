//
//  PlayingCard.h
//  Matchismo
//
//  Created by Udayakumar Pandurangan on 2/3/13.
//  Copyright (c) 2013 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
