//
//  ParentView.m
//  LCHSelfManager
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ParentView.h"
#import "LCHButton.h"
#import <Masonry.h>

@implementation ParentView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _addStarButton = [LCHButton buttonWithType:UIButtonTypeSystem];
        _addStarButton.backgroundColor = [UIColor yellowColor];
        [self addSubview:_addStarButton];
    }
    
    return self;
}

- (void)updateConstraints {
    
    [super updateConstraints];
    [self.addStarButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    }];
}

@end
