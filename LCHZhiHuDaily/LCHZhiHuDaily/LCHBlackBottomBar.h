//
//  LCHBlackBottomBar.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHBlackBottomBar;

@protocol LCHBlackBottomBarDelegate <NSObject>

- (void)blackBottomBarDidPressedBackButton:(LCHBlackBottomBar *)bottomBar;
- (void)blackBottomBarDidPressedRefreshButton:(LCHBlackBottomBar *)bottomBar;
- (void)blackBottomBarDidPressedShareButton:(LCHBlackBottomBar *)bottomBar;

@end

@interface LCHBlackBottomBar : UIView

@property (nonatomic, weak) id<LCHBlackBottomBarDelegate> delegate;

@end
