//
//  LCHSettingUserCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHSettingUserCell.h"
#import "LCHSettingPageConfig.h"

@interface LCHSettingUserCell ()

@property (nonatomic, strong) UIImageView *avatarMask;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *actionLabel;

@end

@implementation LCHSettingUserCell

- (void)configSubviews {
    
    _avatar = [[UIImageView alloc] init];
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.clipsToBounds = YES;
    _avatar.opaque = 0.2f;
    
    _avatarMask = [[UIImageView alloc] init];
    _avatarMask.contentMode = UIViewContentModeScaleAspectFill;
    [_avatarMask setImage:[UIImage imageNamed:kSettingCellAvatarMaskImageName]];
    _avatarMask.clipsToBounds = YES;
    
    _actionLabel = [[UILabel alloc] init];
    _actionLabel.textColor = [UIColor blackColor];
    _actionLabel.font = [UIFont systemFontOfSize:kSettingCellFontSize];
    _actionLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_avatarMask];
    [self.contentView addSubview:_actionLabel];
    [_avatarMask addSubview:_avatar];
}

- (void)configConstraints {
    
    WeakObject(weakAvatar, _avatar);
    
    [_avatarMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kSettingCellAvatarTopPadding));
        make.bottom.offset(-kHeight(kSettingCellAvatarBottomPadding));
        make.left.offset(kWidth(kSettingCellAvatarLeftPadding));
        make.width.mas_equalTo(weakAvatar.mas_height);
    }];
    
    [_actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakAvatar.mas_right).offset(kWidth(kSettingCellLabelLeftPadding));
        make.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.offset(0);
    }];
}

@end
