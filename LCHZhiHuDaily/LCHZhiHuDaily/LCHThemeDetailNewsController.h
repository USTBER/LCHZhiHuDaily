//
//  LCHThemeDetialNewsController.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCHThemeDetailNewsController;

@protocol LCHThemeDetailNewsControllerDelegate <NSObject>

- (void)scrollToFormmerNews:(NSString *)newsID;
- (void)scrollToNextNews:(NSString *)newsID;

@end



@interface LCHThemeDetailNewsController : UIViewController

@property (nonatomic, strong) NSString *newsID;

@property (nonatomic, weak) id<LCHThemeDetailNewsControllerDelegate> delegate;

@end
