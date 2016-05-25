//
//  LCHCollectionViewCell.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCollectionViewCell.h"
#import <NSLayoutConstraint+MASDebugAdditions.h>
#import <Masonry.h>

@interface LCHCollectionViewCell ()

@property (nonatomic, strong) UILabel *newsTypeLabel;


@end

@implementation LCHCollectionViewCell

#pragma overWrite

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _newsTypeLabel = [[UILabel alloc] init];
        _newsTypeLabel.textAlignment = NSTextAlignmentCenter;
        _newsTypeLabel.font = [UIFont systemFontOfSize:18];
        _newsTypeLabel.numberOfLines = 1;
        _newsTypeLabel.backgroundColor = [UIColor randomColor];
        [self.contentView addSubview:_newsTypeLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    WeakSelf(weakSelf);
    [self.newsTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.contentView);
        make.width.greaterThanOrEqualTo(@50);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
    }];
    
}

#pragma mark - lazyLoading

- (void)setNewsColumnName:(NSString *)newsColumnName {
    
    if ([_newsColumnName isEqualToString:newsColumnName]) {
        
        return;
    }
    
    _newsColumnName = newsColumnName;
    self.newsTypeLabel.text = newsColumnName;
//    [self setNeedsLayout];
    CGFloat width = self.newsTypeLabel.width;
    if (![self.delegate respondsToSelector:@selector(currentCollectionViewCell:lableWidthDidChangeTo:)]) {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
        
        return;
    }
    [self.delegate currentCollectionViewCell:self lableWidthDidChangeTo:width];
}

@end
