//
//  LCHCycleView.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHCycleView;
@protocol LCHCycleViewDataSource <NSObject>

- (NSInteger)numberOfViewInCycleView;

- (UIView *)cycleView:(LCHCycleView *)cycleView viewForIndex:(NSInteger)index;

@end

@protocol LCHCycleViewDelegate <NSObject>

- (void)cycleView:(LCHCycleView *)cycleView didSelectAtIndex:(NSInteger)index;

@end

@interface LCHCycleView : UIView

//轮播图片间隔时间
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, weak) id<LCHCycleViewDataSource> dataSource;
@property (nonatomic, weak) id<LCHCycleViewDelegate> delegate;

- (UIView *)viewForIndex:(NSInteger)index;
- (void)reloadData;

@end
