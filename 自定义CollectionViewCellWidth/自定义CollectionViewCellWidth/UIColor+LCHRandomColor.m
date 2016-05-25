//
//  UIColor+LCHRandomColor.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIColor+LCHRandomColor.h"

@implementation UIColor (LCHRandomColor)

+ (UIColor *)randomColor {
    
    CGFloat red = arc4random() % 256 / 256.f;
    CGFloat green = arc4random() % 256 / 256.f;
    CGFloat blue = arc4random() % 256 / 256.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
