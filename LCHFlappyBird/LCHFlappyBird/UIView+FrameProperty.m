//
//  UIView+FrameProperty.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+FrameProperty.h"

@implementation UIView (FrameProperty)

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    if (frame.size.width == width) {
        
        return;
    }
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    if (frame.size.height == height) {
        
        return;
    }
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    if (frame.origin.x == x) {
        
        return;
    }
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    if (frame.origin.y == y) {
        
        return;
    }
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    
    if (self.center.x == centerX) {
        
        return;
    }
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    
    if (self.center.y == centerY) {
        
        return;
    }
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}




@end
