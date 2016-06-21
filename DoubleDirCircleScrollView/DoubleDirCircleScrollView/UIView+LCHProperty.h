//
//  UIView+LCHProperty.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCHProperty)

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;

- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;

- (CGFloat)maxX;
- (CGFloat)maxY;

@end
