//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by STEFANO CORBELLINI on 2/4/13.
//  Copyright (c) 2013 iOS Study Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int         score;
@property (nonatomic, readonly) NSString    *lastResult;

@end
