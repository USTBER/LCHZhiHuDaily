//
//  LCHLongCommentDisplayCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLongCommentDisplayCell.h"
#import "LCHLongCommentDisplayCellConfig.h"

@interface LCHLongCommentDisplayCell ()

@property (nonatomic, strong) UILabel *longCommentNumberLabel;
@property (nonatomic, strong) UIView *bottomLine;

- (void)configSubViews;
- (void)configConstraints;

@end

@implementation LCHLongCommentDisplayCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
        [self configConstraints];
    }
    
    return self;
}

- (void)configSubViews {
    
    _longCommentNumberLabel = [[UILabel alloc] init];
    _longCommentNumberLabel.font = [UIFont systemFontOfSize:kDisplayCellLongCommentNumberLabelFontSize];
    _longCommentNumberLabel.textAlignment = NSTextAlignmentLeft;
    _longCommentNumberLabel.textColor = [UIColor blackColor];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:_longCommentNumberLabel];
    [self addSubview:_bottomLine];
}

- (void)configConstraints {
    
    [_longCommentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWidth(kDisplayCellLongCommentNumberLabelLeftPadding));
        make.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.height.mas_equalTo(@0.2);
        make.bottom.offset(-0.2);
    }];
}

@end
