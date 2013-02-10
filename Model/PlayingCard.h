//
//  PlayingCard.h
//  Matchismo
//
//  Created by STEFANO CORBELLINI on 1/31/13.
//  Copyright (c) 2013 iOS Study Group. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
