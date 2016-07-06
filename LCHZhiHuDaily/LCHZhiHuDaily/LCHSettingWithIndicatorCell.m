//
//  LCHSettingWithIndicatorCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHSettingWithIndicatorCell.h"
#import "LCHSettingPageConfig.h"

@interface LCHSettingWithIndicatorCell ()

@property (nonatomic, strong) UILabel *actionLabel;

@end

@implementation LCHSettingWithIndicatorCell

- (void)configSubviews {
    
    _actionLabel = [[UILabel alloc] init];
    _actionLabel.textColor = [UIColor blackColor];
    _actionLabel.font = [UIFont systemFontOfSize:kSettingCellFontSize];
    _actionLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_actionLabel];
}

- (void)configConstraints {
    
    [_actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(kSettingCellLabelLeftPadding));
        make.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
}


@end
