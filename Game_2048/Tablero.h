//
//  Tablero.h
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableroDelegate;

@interface Tablero : UIView

@property (nonatomic,weak) id<TableroDelegate> delegate;

//Class properties
-(void)addNewChip;

-(void)newGame;

@end

//PROTOCOL
@protocol TableroDelegate <NSObject>

-(void)resetGame;

-(void)setScore:(NSInteger)score;

-(void)gameWon;

@end
