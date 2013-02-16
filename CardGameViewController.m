//
//  CardGameViewController.m
//  Matchismo
//
//  Created by STEFANO CORBELLINI on 1/26/13.
//  Copyright (c) 2013 iOS Study Group. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet                       UILabel  *flipsLabel;
@property (weak, nonatomic) IBOutlet                       UILabel  *lastFlipResults;
@property (nonatomic)                                      int      flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame                      *game;
@property (weak, nonatomic) IBOutlet UILabel                        *scoreLabel;

@end


@implementation CardGameViewController


- (IBAction)dealButton {
    
    // reset score, deck, flipcount, labels
    
    self.game = nil;  // will instantiate w deck using setter (lazy)
    self.flipCount = nil;
    self.lastFlipResults.text = @"flip the first card";
    [self updateUI];
    
    
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!cardButton.selected) {
            [cardButton setBackgroundImage:[UIImage imageNamed:@"bluecard.jpg"] forState:(UIControlStateNormal)];
        } else {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        
 
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}


- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    Card *lastcard = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    self.lastFlipResults.text = self.game.lastResult;
    
    [self updateUI];
}

@end
