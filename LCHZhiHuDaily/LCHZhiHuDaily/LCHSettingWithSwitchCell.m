//
//  LCHSettingWithSwitchCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHSettingWithSwitchCell.h"
#import "LCHSettingPageConfig.h"

@interface LCHSettingWithSwitchCell ()

@property (nonatomic, strong) UILabel *actionLabel;
@property (nonatomic, strong) UISwitch *cellSwitch;

@end


@implementation LCHSettingWithSwitchCell

- (void)configSubviews {
    
    _cellSwitch = [[UISwitch alloc] init];
    
    _actionLabel = [[UILabel alloc] init];
    _actionLabel.textColor = [UIColor blackColor];
    _actionLabel.font = [UIFont systemFontOfSize:kSettingCellFontSize];
    _actionLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_cellSwitch];
    [self.contentView addSubview:_actionLabel];
}

- (void)configConstraints {
    
    [_cellSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kSettingCellSwitchTopPadding));
        make.bottom.offset(-kHeight(kSettingCellSwitchBottomPadding));
        make.right.offset(-kWidth(kSettingCellSwitchRightPadding));
        make.width.mas_equalTo(kWidth(kSettingCellSwitchWidth));
    }];
    
    [_actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(kSettingCellLabelLeftPadding));
        make.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
}


@end
