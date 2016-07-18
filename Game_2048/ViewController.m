//
//  ViewController.m
//  Game_2048
//
//  Created by Alvaro Royo on 13/7/16.
//  Copyright © 2016 alvaroroyo. All rights reserved.
//

#import "ViewController.h"
#import "Panel.h"

@interface ViewController ()

@property (strong,nonatomic) Tablero *table;
@property (strong,nonatomic) Panel *panel;

@property (strong,nonatomic) UIVisualEffectView *gameWonView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** Background **//
    self.view.backgroundColor = [UIColor colorWithHex:@"#FAF8EF" andAlpha:1];
    
    //** Table **//
    self.table = [Tablero new];
    self.table.delegate = self;
    [self.view addSubview:self.table];
    
    //** Panel **//
    self.panel = [[Panel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.table.frame.origin.y)];
    [self.view addSubview:self.panel];
    
    //** ResetButton **//
    UIButton *resetButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.45, 45)];
    resetButton.backgroundColor = [UIColor colorWithHex:@"#EF5350" andAlpha:1];
    resetButton.layer.cornerRadius = 5;
    resetButton.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.table.frame) + resetButton.frame.size.height / 2 + 20);
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
}

#pragma mark - Reset Button action
-(void)resetButtonClick{
    [self.table newGame];
}

#pragma mark - Tablero Delegate
-(void)resetGame{
    [self.panel resetScore];
    [self.gameWonView removeFromSuperview];
}
-(void)setScore:(NSInteger)score{
    [self.panel setScore:score];
}
-(void)gameWon{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.gameWonView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    self.gameWonView.clipsToBounds = YES;
    self.gameWonView.layer.cornerRadius = self.table.layer.cornerRadius;
    self.gameWonView.frame = self.table.frame;
    [self.view addSubview:self.gameWonView];
    
    UILabel *gameWonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.gameWonView.frame.size.width, self.gameWonView.frame.size.height)];
    gameWonLabel.font = [UIFont fontWithName:@"PingFangHK-Medium" size:40];
    gameWonLabel.textAlignment = NSTextAlignmentCenter;
    gameWonLabel.textColor = [UIColor colorWithHex:@"#5DA1E2" andAlpha:1];
    gameWonLabel.text = @"You Win!";
    [self.gameWonView addSubview:gameWonLabel];
}
@end
