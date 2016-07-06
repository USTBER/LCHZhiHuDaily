//
//  LCHShortCommentDisplayCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHShortCommentDisplayCell.h"
#import "LCHShortCommentDisplayCellConfig.h"

@interface LCHShortCommentDisplayCell ()

@property (nonatomic, strong) UILabel *shortCommentNumberLabel;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, assign) BOOL avatarHasChangedDirection;

@end

@implementation LCHShortCommentDisplayCell

- (void)configSubviews {
    
    _shortCommentNumberLabel = [[UILabel alloc] init];
    _shortCommentNumberLabel.font = [UIFont systemFontOfSize:kDisplayCellCommentNumberLabelFontSize];
    _shortCommentNumberLabel.textAlignment = NSTextAlignmentLeft;
    _shortCommentNumberLabel.textColor = [UIColor blackColor];
    
    _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kDisplayCellAvatarImageName]];
    
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    _avatarHasChangedDirection = NO;
    
    [self.contentView addSubview:_shortCommentNumberLabel];
    [self.contentView addSubview:_avatar];
    [self.contentView addSubview:_topLine];
}

- (void)configConstraints {
    
    [_shortCommentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
        make.left.offset(kWidth(kDisplayCellCommentNumberLabelLeftPadding));
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kWidth(kDisplayCellAvatarRightPadding));
        make.top.offset(kHeight(kDisplayCellAvatarTopPadding));
        make.bottom.offset(-kHeight(kDisplayCellAvatarBottomPadding));
        make.width.mas_equalTo(kWidth(kDisplayCellAvatarWidth));
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.offset(0);
        make.height.mas_equalTo(0.25f);
    }];
}

- (void)changeArrowDirection {
    
    if (_avatarHasChangedDirection) {
        _avatar.transform = CGAffineTransformIdentity;
        _avatarHasChangedDirection = NO;
    } else {
        _avatar.transform = CGAffineTransformMakeRotation(M_PI);
        _avatarHasChangedDirection = YES;
    }
}

@end
