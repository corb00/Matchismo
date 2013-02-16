//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by STEFANO CORBELLINI on 2/4/13.
//  Copyright (c) 2013 iOS Study Group. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray    *cards;
@property (nonatomic)         int               score;
@property (strong, nonatomic) NSString          *lastResult;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
    
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.lastResult = nil;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            // check for match
            // question: does *otherCard include original flipped card?
            for (Card *otherCard in self.cards) {
                
                // case of otherCard considered for match (being face up and unplayable)
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable=YES;
                        self.score += matchScore *MATCH_BONUS;
                        self.lastResult = [NSString stringWithFormat:@"Matched  %@ & %@ for %d points",card.contents,otherCard.contents,matchScore *MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastResult = [NSString stringWithFormat:@"no match: %@ & %@ - %d pt penalty",card.contents,otherCard.contents,MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
            
            // Q: why do I have to use "self" here???
            if (!self.lastResult) {self.lastResult = [NSString stringWithFormat:@"Flipped up %@",card.contents];}
        }
        card.faceUp = !card.isFaceUp;
    }
}
@end
