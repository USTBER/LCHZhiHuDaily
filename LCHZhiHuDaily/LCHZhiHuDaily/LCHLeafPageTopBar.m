//
//  LCHLeafPageTopBar.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLeafPageTopBar.h"
#import "LCHLeafPageConfig.h"

@interface LCHLeafPageTopBar ()

@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UIButton *topBackButton;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

- (void)setUpUI;
- (void)configConstraints;

- (void)handleBack:(UIButton *)sender;
- (void)setTitle;
- (void)showIndicatorView;

@end

@implementation LCHLeafPageTopBar


#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self configConstraints];
        [self reloadData];
        self.backgroundColor = kColor(23, 144, 211, 1);
    }
    
    return self;
}

#pragma  mark - private method

- (void)setUpUI {
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.textColor = [UIColor whiteColor];
    _topTitleLabel.font = [UIFont systemFontOfSize:kLeafPageTopTitleLabelFontSize];
    _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _topBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topBackButton setImage:[UIImage imageNamed:@"Back_White"] forState:UIControlStateNormal];
    [_topBackButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.hidesWhenStopped = YES;
    
    [self addSubview:_topBackButton];
    [self addSubview:_topTitleLabel];
    [self addSubview:_indicatorView];
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakBackButton, _topBackButton);
    
    [_topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakBackButton.mas_centerY);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
        make.width.lessThanOrEqualTo(weakSelf).multipliedBy(0.7);
    }];
    
    [_topBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(kLeafPageTopBackButtonLeftPadding));
        make.top.offset(kHeight(kLeafPageTopBackButtonTopPadding));
        make.width.mas_equalTo(kWidth(kLeafPageTopBackButtonWidth));
        make.height.mas_equalTo(kHeight(kLeafPageTopBackButtonHeight));
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakBackButton.mas_centerY);
        make.right.offset(-10);
    }];
}

- (void)handleBack:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(topBarDidPressBack:)]) {
        
        [self.delegate topBarDidPressBack:self];
    }
}

- (void)setTitle {
    
    if ([self.dataSource respondsToSelector:@selector(titleForTopBar:)]) {
        
        self.topTitleLabel.text = [self.dataSource titleForTopBar:self];
    }
}

- (void)showIndicatorView {
    
    if ([self.dataSource respondsToSelector:@selector(shouldShowIndicatorView:)]) {
        
        if (![self.dataSource shouldShowIndicatorView:self]) {
            
            [_indicatorView stopAnimating];
            return;
        }
    }
    [_indicatorView startAnimating];
}

#pragma mark - public method

- (void)reloadData {
    
    [self setTitle];
    [self showIndicatorView];
}

#pragma mark - lazy loading

- (void)setDataSource:(id<LCHLeafPageTopBarDataSource>)dataSource {
    
    _dataSource = dataSource;
    [self reloadData];
}

@end
