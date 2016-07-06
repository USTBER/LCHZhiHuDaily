//
//  LCHConsoleBar.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHConsoleBar.h"
#import "LCHConsoleBarConfig.h"

@interface LCHConsoleBar ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UIButton *sharedButton;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) UILabel *agreeLabel;
@property (nonatomic, strong) UILabel *commentLabel;

- (void)handleBack:(UIButton *)sender;
- (void)handleNext:(UIButton *)sender;
- (void)handleAgree:(UIButton *)sender;
- (void)handleShare:(UIButton *)sender;
- (void)handleComment:(UIButton *)sender;

- (void)setUpUI;
- (void)configConstraints;
- (void)setUpData;

- (NSInteger)agreeNumberFromDataSource;
- (NSInteger)commentNumberFromDataSource;

@end

@implementation LCHConsoleBar


#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self configConstraints];
        [self setUpData];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

#pragma mark - private method

- (void)setUpUI {
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(handleNext:) forControlEvents:UIControlEventTouchUpInside];
    
    _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_agreeButton setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
    [_agreeButton setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateSelected];
    [_agreeButton addTarget:self action:@selector(handleAgree:) forControlEvents:UIControlEventTouchUpInside];
    
    _sharedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sharedButton setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
    [_sharedButton addTarget:self action:@selector(handleShare:) forControlEvents:UIControlEventTouchUpInside];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
    [_commentButton addTarget:self action:@selector(handleComment:) forControlEvents:UIControlEventTouchUpInside];
    
    _agreeLabel = [[UILabel alloc] init];
    _agreeLabel.font = [UIFont systemFontOfSize:kConsoleBarAgreeLabelFontSize];
    _agreeLabel.textAlignment = NSTextAlignmentCenter;
    _agreeLabel.textColor = [UIColor lightGrayColor];
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:kConsoleBarCommentLabelFontSize];
    _commentLabel.textAlignment = NSTextAlignmentCenter;
    _commentLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_backButton];
    [self addSubview:_nextButton];
    [self addSubview:_agreeButton];
    [self addSubview:_sharedButton];
    [self addSubview:_commentButton];
    [self.agreeButton addSubview:_agreeLabel];
    [self.commentButton addSubview:_commentLabel];
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakBackButton, _backButton);
    WeakObject(weakNextButton, _nextButton);
    WeakObject(weakAgreeButton, _agreeButton);
    WeakObject(weakShareButton, _sharedButton);
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.offset(0);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
    }];
    
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(weakBackButton.mas_right);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
    }];
    
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(weakNextButton.mas_right);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
    }];
    
    [_sharedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(weakAgreeButton.mas_right);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(weakShareButton.mas_right);
        make.width.equalTo(weakSelf).multipliedBy(0.2);
    }];
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WeakObject(weakAgreeButton, _agreeButton);
    WeakObject(weakCommentButton, _commentButton);
    
    [_agreeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakAgreeButton.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(weakAgreeButton.width * 0.55);
        make.top.mas_equalTo(weakAgreeButton.height * 0.2);
    }];
    
    [_commentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakCommentButton.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(weakCommentButton.width * 0.5);
        make.top.mas_equalTo(weakCommentButton.height * 0.2);
    }];
}

- (void)setUpData {
    
    NSInteger agreeNum = [self agreeNumberFromDataSource];
    NSInteger commentNum = [self commentNumberFromDataSource];
    self.agreeLabel.text = [NSString stringWithFormat:@"%ld", (long)agreeNum];
    self.commentLabel.text = [NSString stringWithFormat:@"%ld", (long)commentNum];
}

- (NSInteger)agreeNumberFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfAgreeFor:)]) {
        
        return [self.dataSource numberOfAgreeFor:self];
    }
    
    return 0;
}

- (NSInteger)commentNumberFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfCommentFor:)]) {
        
        return [self.dataSource numberOfCommentFor:self];
    }
    
    return 0;
}


#pragma mark - public method

- (void)reloadData {
    
    [self setUpData];
}

#pragma mark - target action

- (void)handleBack:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(backToThemePage:)]) {
        [self.delegate backToThemePage:self];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
}

- (void)handleNext:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(moveToNextDetailNews:)]) {
        [self.delegate moveToNextDetailNews:self];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
}

- (void)handleAgree:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(agreeCurrentNews:)]) {
        [self.delegate agreeCurrentNews:self];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
}

- (void)handleShare:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(shareCurrentNews:)]) {
        [self.delegate shareCurrentNews:self];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
}

- (void)handleComment:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(openCommentPage:)]) {
        [self.delegate openCommentPage:self];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
}

#pragma mark - setter

- (void)setDataSource:(id<LCHConsoleDataSource>)dataSource {
    
    _dataSource = dataSource;
    
    [self reloadData];
}

@end
