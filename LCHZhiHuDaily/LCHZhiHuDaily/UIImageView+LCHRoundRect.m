//
//  UIImageView+LCHRoundRect.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImageView+LCHRoundRect.h"

@implementation UIImageView (LCHRoundRect)

- (void)roundRectImageView {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width] addClip];
    [self drawRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
