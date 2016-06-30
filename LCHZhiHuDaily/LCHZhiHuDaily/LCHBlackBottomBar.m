//
//  LCHBlackBottomBar.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHBlackBottomBar.h"

@interface LCHBlackBottomBar()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UIButton *goForwardButton;
@property (nonatomic, strong) UIButton *goBackwardButton;
@property (nonatomic, strong) UIButton *sharedButton;

- (void)setUpUI;
- (void)configConstraints;

- (void)handleBack:(UIButton *)sender;
- (void)handleRefresh:(UIButton *)sender;
- (void)handleGoforward:(UIButton *)sender;
- (void)handleGoBackward:(UIButton *)sender;
- (void)handleSharedButton:(UIButton *)sender;

@end

@implementation LCHBlackBottomBar


#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    if (self) {
        [self setUpUI];
        [self configConstraints];
        self.backgroundColor = kColor(70, 67, 70, 1);
    }
    
    return self;
}

#pragma mark - private method

- (void)setUpUI {
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"Back_White"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_refreshButton setImage:[UIImage imageNamed:@"Browser_Icon_Reload"] forState:UIControlStateNormal];
    [_refreshButton addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventTouchUpInside];
    
    _goForwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goForwardButton setImage:[UIImage imageNamed:@"Browser_Icon_Forward"] forState:UIControlStateNormal];
    [_goForwardButton setImage:[UIImage imageNamed:@"Browser_Icon_Forward_Disable"] forState:UIControlStateDisabled];
    [_goForwardButton addTarget:self action:@selector(handleGoforward:) forControlEvents:UIControlEventTouchUpInside];
    
    _goBackwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBackwardButton setImage:[UIImage imageNamed:@"Browser_Icon_Back"] forState:UIControlStateNormal];
    [_goBackwardButton setImage:[UIImage imageNamed:@"Browser_Icon_Back_Disable"] forState:UIControlStateDisabled];
    [_goBackwardButton addTarget:self action:@selector(handleGoBackward:) forControlEvents:UIControlEventTouchUpInside];
    
    _sharedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sharedButton setImage:[UIImage imageNamed:@"Browser_Icon_Action"] forState:UIControlStateNormal];
    [_sharedButton addTarget:self action:@selector(handleSharedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_backButton];
    [self addSubview:_refreshButton];
    [self addSubview:_goForwardButton];
    [self addSubview:_goBackwardButton];
    [self addSubview:_sharedButton];
    
    [_goForwardButton setEnabled:NO];
    [_goBackwardButton setEnabled:NO];
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakBackButton, _backButton);
    WeakObject(weakRefreshButton, _refreshButton);
    WeakObject(weakGoForwardButton, _goForwardButton);
    WeakObject(weakGoBackwardButton, _goBackwardButton);
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.offset(0);
        make.height.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
        make.left.offset(0);
    }];
    
    [_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.offset(0);
        make.height.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
        make.left.equalTo(weakBackButton.mas_right);
    }];
    
    [_goForwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.offset(0);
        make.height.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
        make.left.equalTo(weakRefreshButton.mas_right);
    }];
    
    [_goBackwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.offset(0);
        make.height.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
        make.left.equalTo(weakGoForwardButton.mas_right);
    }];
    
    [_sharedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.offset(0);
        make.height.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
        make.left.equalTo(weakGoBackwardButton.mas_right);
    }];
}


- (void)handleBack:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(blackBottomBarDidPressedBackButton:)]) {
        [self.delegate blackBottomBarDidPressedBackButton:self];
    }
}

- (void)handleRefresh:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(blackBottomBarDidPressedRefreshButton:)]) {
        [self.delegate blackBottomBarDidPressedRefreshButton:self];
    }
}

- (void)handleGoforward:(UIButton *)sender {
    
    
}

- (void)handleGoBackward:(UIButton *)sender {
    
    
}

- (void)handleSharedButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(blackBottomBarDidPressedShareButton:)]) {
        [self.delegate blackBottomBarDidPressedShareButton:self];
    }
}

@end
