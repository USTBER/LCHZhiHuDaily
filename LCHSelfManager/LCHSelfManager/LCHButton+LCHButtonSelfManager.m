//
//  LCHButton+LCHButtonSelfManager.m
//  LCHSelfManager
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHButton+LCHButtonSelfManager.h"


@implementation LCHButton (LCHButtonSelfManager)

- (void)setUpButtonWithNumber:(NSInteger)num {
    
    [self configStarWithNum:num];
    [self addTarget:self action:@selector(handleTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleTapped:(LCHButton *)sender{
    
    NSLog(@"增加");
    
}

@end
