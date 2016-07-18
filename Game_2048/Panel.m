//
//  Panel.m
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import "Panel.h"

#define SCORE @"BEST_SCORE"

@interface Panel()

@property (strong,nonatomic) UILabel *scoreText;
@property (strong,nonatomic) UILabel *bestScoreText;

@end

@implementation Panel

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
        _bestScoreNumber = [pref integerForKey:SCORE];
        
        //** SCORE CONTENT **//
        UIView *scoreContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.45, self.frame.size.height * 0.35)];
        scoreContent.backgroundColor = [UIColor colorWithHex:@"#BBADA0" andAlpha:1];
        scoreContent.layer.cornerRadius = 5;
        scoreContent.center = CGPointMake(scoreContent.center.x + self.frame.size.width * 0.025, self.center.y);
        [self addSubview:scoreContent];
        
        UILabel *scoreTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, scoreContent.frame.size.width, 17)];
        scoreTitle.textColor = [UIColor colorWithHex:@"#EEE4DA" andAlpha:1];
        scoreTitle.font = [UIFont fontWithName:@"PingFangHK-Medium" size:17];
        scoreTitle.text = @"Score";
        scoreTitle.textAlignment = NSTextAlignmentCenter;
        [scoreContent addSubview:scoreTitle];
        
        _scoreText = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scoreTitle.frame) + 8, scoreContent.frame.size.width, 25)];
        _scoreText.textColor = [UIColor colorWithHex:@"#FFFFFF" andAlpha:1];
        _scoreText.font = [UIFont fontWithName:@"PingFangHK-Medium" size:25];
        _scoreText.text = @"0";
        _scoreText.textAlignment = NSTextAlignmentCenter;
        [scoreContent addSubview:_scoreText];
        
        
        //** BEST SCORE CONTENT **//
        UIView *bestScoreContent = [[UIView alloc]initWithFrame:CGRectMake(self.center.x + self.frame.size.width * 0.025, 0, self.frame.size.width * 0.45, self.frame.size.height * 0.35)];
        bestScoreContent.backgroundColor = [UIColor colorWithHex:@"#BBADA0" andAlpha:1];
        bestScoreContent.layer.cornerRadius = 5;
        bestScoreContent.center = CGPointMake(bestScoreContent.center.x, self.center.y);
        [self addSubview:bestScoreContent];
        
        UILabel *bestScoreTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, bestScoreContent.frame.size.width, 17)];
        bestScoreTitle.textColor = [UIColor colorWithHex:@"#EEE4DA" andAlpha:1];
        bestScoreTitle.font = [UIFont fontWithName:@"PingFangHK-Medium" size:17];
        bestScoreTitle.text = @"Best Score";
        bestScoreTitle.textAlignment = NSTextAlignmentCenter;
        [bestScoreContent addSubview:bestScoreTitle];
        
        _bestScoreText = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bestScoreTitle.frame) + 8, bestScoreContent.frame.size.width, 25)];
        _bestScoreText.textColor = [UIColor colorWithHex:@"#FFFFFF" andAlpha:1];
        _bestScoreText.font = [UIFont fontWithName:@"PingFangHK-Medium" size:25];
        _bestScoreText.text = [NSString stringWithFormat:@"%li",_bestScoreNumber];
        _bestScoreText.textAlignment = NSTextAlignmentCenter;
        [bestScoreContent addSubview:_bestScoreText];
        
    }
    return self;
}

-(void)setScore:(NSInteger) score{
    _scoreNumber = _scoreNumber + score;
    self.scoreText.text = [NSString stringWithFormat:@"%li",(long)_scoreNumber];
    
    if(self.scoreNumber > self.bestScoreNumber){
        [self setBestScore:score];
    }
}

-(void)setBestScore:(NSInteger) bestScore{
    _bestScoreNumber = _bestScoreNumber + bestScore;
    self.bestScoreText.text = [NSString stringWithFormat:@"%li",(long)_bestScoreNumber];
    
    [[NSUserDefaults standardUserDefaults] setInteger:_bestScoreNumber forKey:SCORE];
    
}

-(void)resetScore{
    self.scoreText.text = @"0";
}

@end
