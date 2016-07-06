//
//  LCHCommentBottomBar.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHCommentBottomBar;

@protocol LCHCommentBottomBarDelegate <NSObject>

- (void)didSelectBack:(LCHCommentBottomBar *)commentBar;
- (void)didSelectWrite:(LCHCommentBottomBar *)commentBar;

@end

@interface LCHCommentBottomBar : UIView

@property (nonatomic, weak) id<LCHCommentBottomBarDelegate> delegate;

@end
