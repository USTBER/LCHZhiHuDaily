//
//  LCHLeafPageTopBar.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHLeafPageTopBar;

@protocol LCHLeafPageTopBarDataSource <NSObject>

- (NSString *)titleForTopBar:(LCHLeafPageTopBar *)topBar;

- (BOOL)shouldShowIndicatorView:(LCHLeafPageTopBar *)topBar;

@end

@protocol LCHLeafPageTopBarDelegate <NSObject>

- (void)topBarDidPressBack:(LCHLeafPageTopBar *)topBar;

@end

@interface LCHLeafPageTopBar : UIView

@property (nonatomic, weak) id<LCHLeafPageTopBarDataSource> dataSource;
@property (nonatomic, weak) id<LCHLeafPageTopBarDelegate> delegate;

- (void)reloadData;

@end
