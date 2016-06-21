//
//  LCHHomePageCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHomePageCell.h"
#import "LCHHomePageConfig.h"

@implementation LCHHomePageCell

- (void)configSubviews {
    
    _newsLabel = [[UILabel alloc] init];
    _newsLabel.textAlignment = NSTextAlignmentLeft;
    _newsLabel.font = [UIFont systemFontOfSize:kHomePageCellTitleLabelFontSize];
    _newsLabel.numberOfLines = 0;
    
    _newsImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_newsLabel];
    [self.contentView addSubview:_newsImageView];
    
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakImageView, _newsImageView);
    [_newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(kWidth(kHomePageCellTitleLabelLeftPadding));
        make.top.equalTo(weakSelf.contentView).offset(kHeight(kHomePageCellTitleLabelTopPadding));
        make.right.equalTo(weakImageView.mas_left).offset(-kWidth(kHomePageCellTitleLabelRightPadding));
        make.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-kWidth(kHomePageCellIconImageViewRightPadding));
        make.top.equalTo(weakSelf.contentView).offset(kHeight(kHomePageCellIconImageViewTopPadding));
        make.bottom.equalTo(weakSelf.contentView).offset(-kHeight(kHomePageCellIconImageViewBottomPadding));
        make.width.mas_equalTo(kWidth(kHomePageCellIconImageViewWidth));
    }];
    
}

@end
