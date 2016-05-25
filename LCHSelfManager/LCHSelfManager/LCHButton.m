//
//  LCHButton.m
//  LCHSelfManager
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHButton.h"
#import <Masonry.h>

@interface LCHButton ()

@property (nonatomic, strong) UILabel *starNumLabel;

@end

@implementation LCHButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _starNumLabel = [[UILabel alloc] init];
        _starNumLabel.textAlignment = NSTextAlignmentCenter;
        _starNumLabel.layer.borderWidth = 2.f;
        _starNumLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _starNumLabel.textColor = [UIColor redColor];
        [self addSubview:_starNumLabel];

    }
    
    return self;
}

- (void)updateConstraints {

    [super updateConstraints];
    [self.starNumLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
}

- (void)configStarWithNum:(NSUInteger)number {
    
    self.starNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)number];
}


@end
