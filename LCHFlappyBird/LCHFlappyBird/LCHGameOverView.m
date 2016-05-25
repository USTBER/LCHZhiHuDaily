//
//  LCHGameOverView.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHGameOverView.h"
#import "Common.h"
#import <Masonry.h>

@interface LCHGameOverView ()

@property (nonatomic, strong) UIImageView *gameOverView;
@property (nonatomic, strong) UIButton *backToMenuButton;
@property (nonatomic, strong) UIButton *restartButton;

- (void)handleBackToMenu:(UIButton *)sender;
- (void)handleRestartButton:(UIButton *)sender;

@end

@implementation LCHGameOverView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _gameOverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameover"]];
        [self addSubview:_gameOverView];
        
        _backToMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backToMenuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [_backToMenuButton addTarget:self action:@selector(handleBackToMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backToMenuButton];
        
        _restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_restartButton setImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
        [_restartButton addTarget:self action:@selector(handleRestartButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_restartButton];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)handleBackToMenu:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(backToMenuWithGameOverView:)]) {
        [self.delegate backToMenuWithGameOverView:self];
    }
    
}

- (void)handleRestartButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(restartGameWithGameOverView:)]) {
        [self.delegate restartGameWithGameOverView:self];
    }
}

- (void)updateConstraints {
    
    WeakSelf(weakSelf);
    [_gameOverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.height.equalTo(weakSelf).multipliedBy(1/5.f);
        make.width.equalTo(weakSelf).multipliedBy(3/4.f);
    }];
    [_backToMenuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(weakSelf).multipliedBy(1/4.f);
        make.width.equalTo(weakSelf).multipliedBy(1/2.f);
    }];
    [_restartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(weakSelf).multipliedBy(1/4.f);
        make.width.equalTo(weakSelf).multipliedBy(1/2.f);
    }];
    
    [super updateConstraints];
}

@end
