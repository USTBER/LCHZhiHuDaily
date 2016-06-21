//
//  LCHCircleView.h
//  DoubleDirCircleScrollView
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LCHCircleViewType) {
    
    LCHCircleViewTypeNotAutomatic = 0,
    LCHCircleViewTypeaForwardAutomatic,
    LCHCircleViewTypeBackwardAutomatic,
};

typedef NS_ENUM(NSUInteger, LCHCircieViewScrollDirection) {
    
    LCHCircleViewScrollDirectionVertical,
    LCHCircleViewScrollDirectionHorizon
};

@class LCHCircleView;
@class LCHCircleCell;

@protocol LCHCircleViewDataSource <NSObject>

- (NSUInteger)numberOfCircleCellInCircleView:(LCHCircleView *)circleView;

- (LCHCircleCell *)circleView:(LCHCircleView *)circleView cellIndex:(NSUInteger)index;

@end

@interface LCHCircleView : UIView

@property (nonatomic, readonly, assign) LCHCircleViewType circleType;
@property (nonatomic, readonly, assign) LCHCircieViewScrollDirection scrollDirection;
@property (nonatomic, weak) id<LCHCircleViewDataSource> dataSource;

- (id)initWithType:(LCHCircleViewType)type;
- (id)initWithScrollDirection:(LCHCircieViewScrollDirection)scrollDirection;
- (id)initWithType:(LCHCircleViewType)type frame:(CGRect)frame;
- (id)initWithScrollDirection:(LCHCircieViewScrollDirection)scrollDirection frame:(CGRect)frame;
- (id)initWithType:(LCHCircleViewType)type scrollDirection:(LCHCircieViewScrollDirection)scrollDirection;
- (id)initWithType:(LCHCircleViewType)type scrollDirection:(LCHCircieViewScrollDirection)scrollDirection frame:(CGRect)frame;

- (void)reloadData;

@end
