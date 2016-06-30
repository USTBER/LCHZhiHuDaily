//
//  LCHRecommendersView.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHRecommendersView;

@protocol LCHRecommendersViewDataSource <NSObject>

- (NSInteger)numberOfRecommenders:(LCHRecommendersView *)recommendersView;

- (NSString *)recommenderView:(LCHRecommendersView *)recommendersView imageURLForIndex:(NSInteger)index;

@end

@protocol LCHRecommendersViewDelegate <NSObject>

- (void)recommenderView:(LCHRecommendersView *)recommendersView didSelectRecommenderAtIndex:(NSInteger)index;

@end

@interface LCHRecommendersView : UIView

@property (nonatomic, weak) id<LCHRecommendersViewDataSource> dataSource;
@property (nonatomic, weak) id<LCHRecommendersViewDelegate> delegate;

- (void)reloadData;

@end
