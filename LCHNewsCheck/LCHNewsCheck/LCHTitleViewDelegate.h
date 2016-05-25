//
//  LCHTitleViewDelegate.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCHTitleView;
@protocol LCHTitleViewDelegate <NSObject>

- (CGFloat)titleView:(LCHTitleView *)titleView indicatorWidthForIndex:(NSUInteger)index;

- (CGFloat)titleView:(LCHTitleView *)titleView indicatorXForIndex:(NSUInteger)index;

@end
