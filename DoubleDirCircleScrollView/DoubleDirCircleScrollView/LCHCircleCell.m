//
//  LCHCircleCell.m
//  DoubleDirCircleScrollView
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCircleCell.h"

@implementation LCHCircleCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        _label.width = 200;
        _label.height = 100;
        [self addSubview:_label];
    }
    
    return self;
}

@end
