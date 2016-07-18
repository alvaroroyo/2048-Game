//
//  Tablero.m
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import "Tablero.h"
#include <math.h>
#import "Ficha.h"

//Logics moves
#define LEFT_MOVE @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15]
#define RIGHT_MOVE @[@3,@2,@1,@0,@7,@6,@5,@4,@11,@10,@9,@8,@15,@14,@13,@12]
#define DOWN_MOVE @[@12,@8,@4,@0,@13,@9,@5,@1,@14,@10,@6,@2,@15,@11,@7,@3]
#define UP_MOVE @[@0,@4,@8,@12,@1,@5,@9,@13,@2,@6,@10,@14,@3,@7,@11,@15]

@interface Tablero()

@property (strong,nonatomic) NSArray<UIView *> *chipsPositions;
@property (strong,nonatomic) NSMutableArray<Ficha *> *chipsInGame;

@end

@implementation Tablero

-(id)init{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat marginLeft = screenSize.width * 0.025;
    if(self = [super initWithFrame:CGRectMake(marginLeft, screenSize.height / 2 - ((screenSize.width - marginLeft * 2) / 2) + 50, screenSize.width - marginLeft * 2, screenSize.width - marginLeft * 2)]){
        
        self.chipsInGame = [NSMutableArray new];
        for (int i = 0; i<16; i++) {
            [self.chipsInGame insertObject:[Ficha new] atIndex:i];
        }
        
        self.backgroundColor = [UIColor colorWithHex:@"#BBADA0" andAlpha:1];
        
        self.layer.cornerRadius = self.frame.size.height * 0.025;
        
        //** SET CHIP POSITION **//
        NSMutableArray *chipPositionsMutable = [NSMutableArray new];
        
        CGFloat surface = self.frame.size.width * self.frame.size.width;
        
        CGFloat marginSurface = surface * 0.47;
        
        CGFloat chipSurface = surface - marginSurface;
        
        CGFloat chipWidth = sqrt(chipSurface / 16);
        
        CGFloat chipMargin = sqrt(marginSurface) / 13;
        
        CGFloat marginY = chipMargin;
        CGFloat marginX = chipMargin;
        for (int i = 0; i < 16; i++) {
            UIView *chipPosition = [[UIView alloc]initWithFrame:CGRectMake(marginX, marginY, chipWidth, chipWidth)];
            chipPosition.backgroundColor = [UIColor colorWithHex:@"#CDC1B4" andAlpha:1];
            chipPosition.layer.cornerRadius = chipPosition.frame.size.height * 0.05;
            [self addSubview:chipPosition];
            
            [chipPositionsMutable setObject:chipPosition atIndexedSubscript:i];
            
            if( (i + 1) % 4 != 0 ){
                marginX = CGRectGetMaxX(chipPosition.frame) + chipMargin;
            }else{
                marginX = chipMargin;
                marginY = CGRectGetMaxY(chipPosition.frame) + chipMargin;
            }
            
        }
        
        _chipsPositions = chipPositionsMutable;
        
        //** SWIPE RECOGNIZER **//
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUp];
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeDown];
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        [self addGestureRecognizer:swipeRight];
        
        [self addNewChip];
        [self addNewChip];
    }
    return self;
}

-(void)swipeAction:(UISwipeGestureRecognizer *)sender{
    
    if(sender.direction == UISwipeGestureRecognizerDirectionDown){
        //DOWN
        [self gameLogicWithDirection:DOWN_MOVE];
    }else if(sender.direction == UISwipeGestureRecognizerDirectionUp){
        //UP
        [self gameLogicWithDirection:UP_MOVE];
    }else if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
        //LEFT
        [self gameLogicWithDirection:LEFT_MOVE];
    }else if(sender.direction == UISwipeGestureRecognizerDirectionRight){
        //RIGHT
        [self gameLogicWithDirection:RIGHT_MOVE];
    }
}

-(NSArray*)getEmptySlots{
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<16; i++) {
        if(self.chipsInGame[i].chipNumber == 0){
            [array addObject:[NSNumber numberWithInt:i]];
        }
    }
    return array;
}

-(void)addNewChip{
    NSArray<NSNumber*> *emptySlots = [self getEmptySlots];
    int arrayPosition = arc4random() % [emptySlots count];
    int randNumber = arc4random() % 100;
    Ficha *ficha = [[Ficha alloc] initWithViewPosition:self.chipsPositions[[emptySlots[arrayPosition] integerValue]] andInitialNumber:randNumber < 75 ? 2 : 4];
    ficha.chipPosition = [emptySlots[arrayPosition] integerValue];
    [self addSubview:ficha];
    [self.chipsInGame replaceObjectAtIndex:[emptySlots[arrayPosition] integerValue] withObject:ficha];
}

//DEBUG METHOD
-(void)addNewChipToPosition:(NSInteger)position andNumber:(NSInteger)number{
    Ficha *ficha = [[Ficha alloc] initWithViewPosition:self.chipsPositions[position] andInitialNumber:number];
    ficha.chipPosition = position;
    [self addSubview:ficha];
    [self.chipsInGame replaceObjectAtIndex:position withObject:ficha];
}

-(void)newGame{
    for (int i = 0; i<16; i++) {
        self.chipsInGame[i].hidden = YES;
        [self.chipsInGame replaceObjectAtIndex:i withObject:[Ficha new]];
    }
    [self addNewChip];
    [self addNewChip];
    [self.delegate resetGame];
}

#pragma mark - GAME LOGIC
-(void)gameLogicWithDirection:(NSArray<NSNumber*>*)dir{
    NSInteger column = 0;
    
    NSInteger scorePoints = 0;
    
    NSInteger lastPosition = -1;
    
    Ficha *lastChip = nil;
    
    BOOL movement = NO;
    
    //Start Logic
    for (int i = 0; i<16; i++) {
        BOOL sum = NO;
        
        //True index
        NSInteger e = [dir[i] integerValue];
        
        //Get the chip for actual position
        Ficha *actualChip = self.chipsInGame[e];
        
        if(actualChip.chipNumber == 0 && lastPosition == -1){
            lastPosition = e;
        }
        
        if(lastChip.chipNumber == actualChip.chipNumber && actualChip.chipNumber != 0){
            //Chips sum
            sum = YES;
            movement = YES;
            
            NSInteger moveTo = lastChip.chipPosition;

            //Animations
            [self bringSubviewToFront:lastChip];
            [lastChip moveChipToPosition:self.chipsPositions[moveTo].frame andTransformTo:lastChip.chipNumber * 2];
            [actualChip moveChipToPosition:self.chipsPositions[moveTo].frame andDisappear:YES];
            
            //Set matrix
            self.chipsInGame[moveTo] = lastChip;
            if(moveTo == lastPosition)
                self.chipsInGame[lastChip.chipPosition] = [Ficha new];
            lastChip.chipPosition = moveTo;
            self.chipsInGame[actualChip.chipPosition] = [Ficha new];
            
            //Set last position
            lastPosition = [dir[[dir indexOfObject:[NSNumber numberWithInteger:moveTo]] + 1] integerValue];
            
            scorePoints = scorePoints + lastChip.chipNumber * 2;
            
            lastChip = nil;
            
            //Game won
            if(actualChip.chipNumber * 2 == 2048){ [self.delegate gameWon]; }
            
        }else if(actualChip.chipNumber != 0 && lastPosition != -1){
            //Move only one chip
            movement = YES;
            
            //Animation
            [actualChip moveChipToPosition:self.chipsPositions[lastPosition].frame andDisappear:NO];
            actualChip.chipPosition = lastPosition;
            
            //Set matrix
            self.chipsInGame[lastPosition] = actualChip;
            self.chipsInGame[e] = [Ficha new];
            
            //Set last position
            lastPosition = [dir[[dir indexOfObject:[NSNumber numberWithInteger:lastPosition]] + 1] integerValue];
        }
        
        if( (i + 1) % 4 == 0){
            lastChip = nil;
            lastPosition = -1;
            column = column + 1;
        }else if(actualChip.chipNumber != 0 && !sum){
            lastChip = actualChip;
        }
    }
    
    //Add score
    if(scorePoints > 0){ [self.delegate setScore:scorePoints]; }
    
    //New chip in table
    if(movement){ [self addNewChip]; }
}

@end
