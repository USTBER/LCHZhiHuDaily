//
//  LCHGameOverDelegate.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCHGameOverView;
@protocol LCHGameOverDelegate <NSObject>

- (void)backToMenuWithGameOverView:(LCHGameOverView *)gameOverView;
- (void)restartGameWithGameOverView:(LCHGameOverView *)gameOverView;

@end
