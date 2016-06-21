//
//  LCHTopHeadView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHTopHeadView.h"

@implementation LCHTopHeadView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.numberOfLines = 0;
        
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.textColor = [UIColor whiteColor];
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        [self addSubview:_sourceLabel];
        
        WeakObject(weakSelf, self);
        WeakObject(weakSourceLabel, _sourceLabel);
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.width.and.height.equalTo(weakSelf);
        }];
        
        [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(kWidth(15));
            make.bottom.equalTo(weakSelf).offset(-kWidth(8));
            make.height.mas_equalTo(kHeight(21));
            make.width.greaterThanOrEqualTo(@0.1);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(kWidth(15));
            make.bottom.equalTo(weakSourceLabel.mas_top);
            make.width.greaterThanOrEqualTo(@0.1);
            make.right.equalTo(weakSelf).offset(-kWidth(15));
        }];
    }
    
    return self;
}


@end
