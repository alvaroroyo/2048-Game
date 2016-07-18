//
//  Panel.h
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Panel : UIView

@property (nonatomic,readonly) NSInteger scoreNumber;
@property (nonatomic,readonly) NSInteger bestScoreNumber;

-(void)setScore:(NSInteger) score;

-(void)setBestScore:(NSInteger) bestScore;

-(void)resetScore;

@end
