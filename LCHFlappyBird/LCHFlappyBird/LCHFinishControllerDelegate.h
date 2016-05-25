//
//  LCHFinishControllerDelegate.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCHBaseController;
@protocol LCHFinishControllerDelegate <NSObject>

- (void)finishCurrentController:(LCHBaseController *)currentController;

@end
