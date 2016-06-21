//
//  LCHThemeNewsCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeNewsCell.h"
#import "LCHThemePageConfig.h"

@interface LCHThemeNewsCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LCHThemeNewsCell

- (void)configSubviews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:kCellTitleLabelFontSize];
    _titleLabel.numberOfLines = 0;
    
    _iconImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_iconImageView];
    
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(kWidth(kCellTitleLabelLeftPadding));
        make.top.equalTo(weakSelf.contentView).offset(kHeight(kCellTitleLabelTopPadding));
        make.right.equalTo(weakSelf.contentView).offset(-kWidth(kCellTitleLabelRightPadding));
        make.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-kWidth(kCellIconImageViewRightPadding));
        make.top.equalTo(weakSelf.contentView).offset(kHeight(kCellIconImageViewTopPadding));
        make.bottom.equalTo(weakSelf.contentView).offset(-kHeight(kCellIconImageViewBottomPadding));
        make.width.mas_equalTo(kWidth(kCellIconImageViewWidth));
    }];
}

#pragma mark - lazy loading

- (void)setIconImageViewURL:(NSString *)iconImageViewURL {
    
    if (_iconImageViewURL == iconImageViewURL) {
        
        return;
    }
    
    _iconImageViewURL = iconImageViewURL;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:iconImageViewURL]];
    
    WeakObject(weakSelf, self);
    WeakObject(weakImageView, _iconImageView);
    
    if (iconImageViewURL) {
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakImageView.mas_left).offset(-kWidth(kCellTitleLabelRightPadding));
            make.left.equalTo(weakSelf.contentView).offset(kWidth(kCellTitleLabelLeftPadding));
            make.top.equalTo(weakSelf.contentView).offset(kHeight(kCellTitleLabelTopPadding));
            make.height.greaterThanOrEqualTo(@0.1);
        }];
    } else {
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView).offset(-kWidth(kCellTitleLabelRightPadding));
            make.left.equalTo(weakSelf.contentView).offset(kWidth(kCellTitleLabelLeftPadding));
            make.top.equalTo(weakSelf.contentView).offset(kHeight(kCellTitleLabelTopPadding));
            make.height.greaterThanOrEqualTo(@0.1);
        }];
    }
}

@end
