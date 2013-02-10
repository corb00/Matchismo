//
//  Card.m
//  Matchismo
//
//  Created by STEFANO CORBELLINI on 1/26/13.
//  Copyright (c) 2013 iOS Study Group. All rights reserved.
//

#import "Card.h"


@interface Card()

@end



@implementation Card

- (int)match:(Card *)otherCards
{
    int score = 0;

    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
        score = 1;
        }
    }
    
    
    return score;
}

@end
