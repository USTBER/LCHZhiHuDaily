//
//  UIView+LCHExpand.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCHExpand)

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

- (CGSize)size;
- (void)setSize:(CGSize)size;

@end
