//
//  LCHCommentBottomBar.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCommentBottomBar.h"
#import "LCHCommentPageConfig.h"

@interface LCHCommentBottomBar ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *writeButton;
@property (nonatomic, strong) UIImageView *writeIcon;
@property (nonatomic, strong) UILabel *writeLabel;
@property (nonatomic, strong) UIView *whiteLine;

- (void)configSubViews;
- (void)configConstraints;

- (void)userDidSelectBack;
- (void)userDidSelectWrite;

@end

@implementation LCHCommentBottomBar

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
        [self configConstraints];
    }
    
    return self;
}

#pragma mark - private method

- (void)configSubViews {
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kCommentBottomBarBackgroundImage]];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:kCommentBottomBarBackButtonImage] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(userDidSelectBack) forControlEvents:UIControlEventTouchUpInside];
    
    _writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _writeButton.backgroundColor = [UIColor clearColor];
    [_writeButton addTarget:self action:@selector(userDidSelectWrite) forControlEvents:UIControlEventTouchUpInside];
    
    _writeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kCommentBottomBarWriteIconImage]];
    
    _writeLabel = [[UILabel alloc] init];
    _writeLabel.textColor = [UIColor lightTextColor];
    _writeLabel.font = [UIFont systemFontOfSize:kCommentBottomBarWriteLabelFontSize];
    _writeLabel.textAlignment = NSTextAlignmentCenter;
    _writeLabel.text = kCommentBottomBarWriteLabelText;
    
    _whiteLine = [[UIView alloc] init];
    _whiteLine.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    
    [self addSubview:_backgroundImageView];
    [self addSubview:_backButton];
    [self addSubview:_writeButton];
    [self addSubview:_whiteLine];
    [_writeButton addSubview:_writeIcon];
    [_writeButton addSubview:_writeLabel];
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakBackButton, _backButton);
    WeakObject(weakWhiteLine, _whiteLine);
    WeakObject(weakLabel, _writeLabel);
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.offset(0);
    }];
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.offset(0);
        make.width.equalTo(weakSelf).multipliedBy(0.2f);
    }];
    
    [_whiteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.offset(0);
        make.left.equalTo(weakBackButton.mas_right);
        make.width.equalTo(@0.3f);
    }];
    
    [_writeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.offset(0);
        make.left.equalTo(weakWhiteLine.mas_right);
    }];
    
    [_writeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_writeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakLabel.mas_left);
        make.centerY.offset(0);
        make.width.mas_equalTo(kCommentBottomBarWriteIconWidth);
        make.height.mas_equalTo(kCommentBottomBarWriteIconHeight);
    }];
}


#pragma mark - send action to deleagte

- (void)userDidSelectBack {
    
    if ([self.delegate respondsToSelector:@selector(didSelectBack:)]) {
        [self.delegate didSelectBack:self];
    }
}

- (void)userDidSelectWrite {
    
    if ([self.delegate respondsToSelector:@selector(didSelectWrite:)]) {
        [self.delegate didSelectWrite:self];
    }
}


@end
