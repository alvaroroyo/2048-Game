//
//  Ficha.h
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ficha : UIView

@property (nonatomic) __block NSInteger chipNumber;
@property (nonatomic) NSInteger chipPosition;

-(id)initWithViewPosition:(UIView *)view andInitialNumber:(NSInteger) initialNumber;

-(void)moveChipToPosition:(CGRect)position andTransformTo:(NSInteger)chipNumber;
-(void)moveChipToPosition:(CGRect)position andDisappear:(BOOL)disappear;

@end
