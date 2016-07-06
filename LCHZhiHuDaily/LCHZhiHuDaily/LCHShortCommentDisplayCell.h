//
//  LCHShortCommentDisplayCell.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHBaseTableViewCell.h"

@interface LCHShortCommentDisplayCell : LCHBaseTableViewCell

@property (nonatomic, readonly, strong) UILabel *shortCommentNumberLabel;
@property (nonatomic, readonly, strong) UIImageView *avatar;

- (void)changeArrowDirection;

@end
