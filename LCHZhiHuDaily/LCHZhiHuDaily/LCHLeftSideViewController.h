//
//  LCHLeftSideViewController.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHLeftSideDrawerDelegate.h"

@interface LCHLeftSideViewController : UIViewController

@property (nonatomic, weak) id<LCHLeftSideDrawerDelegate> delegate;

@end
