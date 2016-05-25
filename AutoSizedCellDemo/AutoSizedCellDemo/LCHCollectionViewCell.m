//
//  LCHCollectionViewCell.m
//  AutoSizedCellDemo
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCollectionViewCell.h"

@implementation LCHCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.backgroundColor = [UIColor redColor];
        _firstLabel.font = [UIFont systemFontOfSize:25];
        
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.backgroundColor = [UIColor greenColor];
        _secondLabel.font = [UIFont systemFontOfSize:25];
        
        [self.contentView addSubview:_firstLabel];
        [self.contentView addSubview:_secondLabel];
        
        self.backgroundColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
  
    CGSize sizeForFirstLabel = [self.firstLabel.text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size;
    self.firstLabel.frame = CGRectMake(0, 0, sizeForFirstLabel.width, sizeForFirstLabel.height);
    
    CGSize sizeForSecondLabel = [self.secondLabel.text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size;
    self.secondLabel.frame = CGRectMake(sizeForFirstLabel.width, 0, sizeForSecondLabel.width, sizeForSecondLabel.height);
    
    CGRect frame = self.contentView.frame;
    frame.size = CGSizeMake(sizeForFirstLabel.width + sizeForSecondLabel.width, MAX(sizeForFirstLabel.height, sizeForSecondLabel.height));
    self.contentView.frame = frame;
    
    CGRect cellFrame = self.frame;
    cellFrame.size = self.contentView.frame.size;
    self.frame = cellFrame;
    
}


@end
