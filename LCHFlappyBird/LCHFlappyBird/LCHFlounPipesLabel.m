//
//  LCHFlounPipesLabel.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHFlounPipesLabel.h"

@implementation LCHFlounPipesLabel

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:@"Marker Felt" size:150];
        self.textColor = [UIColor colorWithRed:0.6 green:0.5 blue:0.5 alpha:0.5];
        self.text = @"0";
        self.layer.opacity = 0.3;
    }
    
    return self;
}

@end
