//
//  LCHGameOverView.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHGameOverDelegate.h"

@interface LCHGameOverView : UIView

@property (nonatomic, weak) id<LCHGameOverDelegate> delegate;

@end
