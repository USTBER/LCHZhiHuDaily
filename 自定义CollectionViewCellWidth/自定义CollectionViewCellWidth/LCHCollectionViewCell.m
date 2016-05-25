//
//  LCHCollectionViewCell.m
//  自定义CollectionViewCellWidth
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCollectionViewCell.h"
#import <Masonry.h>

@interface LCHCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation LCHCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:15];
        _label.backgroundColor = [UIColor randomColor];
        [self.contentView addSubview:_label];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    WeakSelf(weakSelf);
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(weakSelf);
    }];
    

}

- (void)setNewsTitle:(NSString *)newsTitle {
    
    if ([_newsTitle isEqualToString:newsTitle]) {
        
        return;
    }
    _newsTitle = newsTitle;
    self.label.text = newsTitle;
    [self.label layoutIfNeeded];
    CGFloat width = self.label.width;
    
    if (![self.delegate respondsToSelector:@selector(currentCollectionViewCell:lableWidthDidChangeTo:)]) {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
        
        return;
    }
    [self.delegate currentCollectionViewCell:self lableWidthDidChangeTo:width];
    
}



@end
