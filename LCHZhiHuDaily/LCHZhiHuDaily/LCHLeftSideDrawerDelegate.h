//
//  LCHLeftSideDrawerDelegate.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCHThemeModel;

@protocol LCHLeftSideDrawerDelegate <NSObject>

- (void)switchToHome;

- (void)switchToOtherTheme:(LCHThemeModel *)themeModel;

- (void)switchToMessage;

- (void)switchToSetting;

@end
