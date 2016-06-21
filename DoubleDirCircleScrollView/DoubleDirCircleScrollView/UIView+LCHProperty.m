//
//  UIView+LCHProperty.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+LCHProperty.h"

@implementation UIView (LCHProperty)

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
    
    CGPoint center = self.center;
    if (center.x == centerX) {
        
        return;
    }
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    if (center.y == centerY) {
        
        return;
    }
    center.y = centerY;
    self.center = center;
}


- (CGFloat)maxX {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)maxY {
    
    return self.frame.origin.y + self.frame.size.height;
}





@end
