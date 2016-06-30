//
//  LCHConsoleBar.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHConsoleBar;

@protocol LCHConsoleBarDelegate <NSObject>

@required

- (void)backToThemePage:(LCHConsoleBar *)consoleBar;
- (void)moveToNextDetailNews:(LCHConsoleBar *)consoleBar;

@end

@protocol LCHConsoleDataSource <NSObject>

@required

- (NSInteger)numberOfAgreeFor:(LCHConsoleBar *)consoleBar;
- (NSInteger)numberOfCommentFor:(LCHConsoleBar *)consoleBar;

@end

@interface LCHConsoleBar : UIView

@property (nonatomic, weak) id<LCHConsoleBarDelegate> delegate;
@property (nonatomic, weak) id<LCHConsoleDataSource> dataSource;

- (void)reloadData;

@end
