//
//  LCHCommentCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCommentCell.h"
#import "LCHCommentCellConfig.h"

@interface LCHCommentCell ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation LCHCommentCell

- (void)configSubviews {
    
    _avatar = [[UIImageView alloc] init];
    _avatar.contentMode = UIViewContentModeScaleAspectFit;
    
    _authorNameLabel = [[UILabel alloc] init];
    _authorNameLabel.font = [UIFont systemFontOfSize:kCommentCellAuthorNameLabelFontSize];
    _authorNameLabel.textAlignment = NSTextAlignmentCenter;
    _authorNameLabel.textColor = [UIColor blackColor];
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:kCommentCellCommentLabelFontSize];
    _commentLabel.textAlignment = NSTextAlignmentLeft;
    _commentLabel.textColor = [UIColor blackColor];
    _commentLabel.numberOfLines = 0;
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:kCommentCellDateLabelFontSize];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_avatar];
    [self.contentView addSubview:_authorNameLabel];
    [self.contentView addSubview:_commentLabel];
    [self.contentView addSubview:_dateLabel];
}

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakAuthorNameLabel, _authorNameLabel);
    WeakObject(weakCommentLabel, _commentLabel);
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kCommentCellAvatarTopPadding));
        make.left.offset(kWidth(kCommentCellAvatarLeftPadding));
        make.width.mas_equalTo(kWidth(kCommentCellAvatarWidth));
        make.height.mas_equalTo(kHeight(kCommentCellAvatarHeight));
    }];
    
    [_authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kHeight(kCommentCellAuthorNameLabelTopPadding));
        make.left.offset(kWidth(kCommentCellAuthorNameLabelLeftPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakAuthorNameLabel.mas_bottom).offset(kHeight(kCommentCellCommentLabelTopPadding));
        make.left.offset(kWidth(kCommentCellCommentLabelLeftPadding));
        make.right.offset(-kWidth(kCommentCellCommentLabelRightPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakCommentLabel.mas_bottom).offset(kHeight(kCommentCellDateLabelTopPadding));
        make.left.offset(kWidth(kCommentCellDateLabelLeftPadding));
        make.width.greaterThanOrEqualTo(@0.1);
        make.bottom.equalTo(weakSelf.contentView).offset(-kHeight(kCommentCellDateLabelBottomPadding)).priorityLow();
    }];
}

@end
