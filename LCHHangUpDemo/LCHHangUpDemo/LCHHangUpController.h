//
//  LCHHangUpController.h
//  LCHHangUpDemo
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCHHangUpControllerDelegate <NSObject>

- (void)finishCurrentController:(UIViewController *)currentController;

@end

@interface LCHHangUpController : UIViewController

@property (nonatomic, weak) id<LCHHangUpControllerDelegate> delegate;

@end
