//
//  LCHCommentCell.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHBaseTableViewCell.h"

@interface LCHCommentCell : LCHBaseTableViewCell

@property (nonatomic, readonly, strong) UIImageView *avatar;
@property (nonatomic, readonly, strong) UILabel *authorNameLabel;
@property (nonatomic, readonly, strong) UILabel *commentLabel;
@property (nonatomic, readonly, strong) UILabel *dateLabel;

@end
