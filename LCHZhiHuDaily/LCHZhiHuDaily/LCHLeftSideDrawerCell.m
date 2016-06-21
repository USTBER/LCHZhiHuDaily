//
//  LCHLeftSideDrawerCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLeftSideDrawerCell.h"
#import "LCHLeftSideDrawerConfig.h"

@interface LCHLeftSideDrawerCell ()

@property (nonatomic, strong) UILabel *themeLabel;

@end

@implementation LCHLeftSideDrawerCell

- (void)configSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = kColor(31, 38, 46, 1);
    
    _themeLabel = [[UILabel alloc] init];
    _themeLabel.textAlignment = NSTextAlignmentLeft;
    _themeLabel.textColor = kColor(128, 133, 140, 1);
    _themeLabel.highlightedTextColor = [UIColor whiteColor];

    [self.contentView addSubview:_themeLabel];
    
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    [_themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(kThemeLabelLeftPadding);
        make.right.equalTo(weakSelf.contentView).offset(kThemeLabelRightPadding);
        make.top.and.bottom.equalTo(weakSelf.contentView);

    }];

    
}

@end
