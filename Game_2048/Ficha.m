//
//  Ficha.m
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import "Ficha.h"

#define CHIP_COLORS @{@"2":@"#EEE4DA",@"4":@"#EDE0C8",@"8":@"#F2B179",@"16":@"#F59563",@"32":@"#F67C5F",@"64":@"#EB423F",@"128":@"#F5D077",@"256":@"#F3C62B",@"512":@"#74B5DD",@"1024":@"#5DA1E2",@"2048":@"#007FC2"}
#define NUMBERS_COLORS @{@"2":@"#776E65",@"4":@"#776E65",@"8":@"#FFFFFF",@"16":@"#FFFFFF",@"32":@"#FFFFFF",@"64":@"#FFFFFF",@"128":@"#FFFFFF",@"256":@"#FFFFFF",@"512":@"#FFFFFF",@"1024":@"#FFFFFF",@"2048":@"#FFFFFF"}

#define APPEAR_ANIMATION_DELAY 0.3
#define TRANSLATE_ANIMATION_DELAY 0.3

@interface Ficha()

@property (strong,nonatomic) UILabel *numberLabel;

@end

@implementation Ficha

-(id)init{
    if(self = [super init]){
        _chipNumber = 0;
        _chipPosition = -1;
    }
    return self;
}

-(id)initWithViewPosition:(UIView *)view andInitialNumber:(NSInteger)initialNumber{
    if(self = [super initWithFrame:view.frame]){
        
        self.backgroundColor = [UIColor colorWithHex:[CHIP_COLORS valueForKey:[NSString stringWithFormat:@"%li",(long)initialNumber]] andAlpha:1];
        self.layer.cornerRadius = view.layer.cornerRadius;
        
        _chipNumber = initialNumber;
        
        self.numberLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.numberLabel.textColor = [UIColor colorWithHex:[NUMBERS_COLORS valueForKey:[NSString stringWithFormat:@"%li",(long)initialNumber]] andAlpha:1];
        self.numberLabel.font = [UIFont fontWithName:@"PingFangHK-Medium" size:23];
        self.numberLabel.text = [NSString stringWithFormat:@"%li",(long)initialNumber];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.numberLabel];
        
        self.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:APPEAR_ANIMATION_DELAY animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
    }
    return self;
}

-(void)setChipNumber:(NSInteger)chipNumber{
        _chipNumber = chipNumber;
        self.backgroundColor = [UIColor colorWithHex:[CHIP_COLORS valueForKey:[NSString stringWithFormat:@"%li",(long)chipNumber]] andAlpha:1];
        self.numberLabel.textColor = [UIColor colorWithHex:[NUMBERS_COLORS valueForKey:[NSString stringWithFormat:@"%li",(long)chipNumber]] andAlpha:1];
        self.numberLabel.font = [UIFont fontWithName:@"PingFangHK-Medium" size:23];
        self.numberLabel.text = [NSString stringWithFormat:@"%li",(long)chipNumber];
}

-(void)moveChipToPosition:(CGRect)position andTransformTo:(NSInteger)chipNumber{
    [UIView animateWithDuration:TRANSLATE_ANIMATION_DELAY animations:^{
        self.frame = position;
    } completion:^(BOOL finished) {
        self.chipNumber = chipNumber;
    }];
}
-(void)moveChipToPosition:(CGRect)position andDisappear:(BOOL)disappear{
    [UIView animateWithDuration:TRANSLATE_ANIMATION_DELAY animations:^{
        self.frame = position;
    } completion:^(BOOL finished) {
        if(disappear){ self.hidden = YES; }
    }];
}

@end
