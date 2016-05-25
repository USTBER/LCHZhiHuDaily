//
//  LCHBackToMenuDelegate.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCHGameController;
@protocol LCHBackToMenuDelegate <NSObject>

- (void)finishController:(LCHGameController *)gameController reloadCurrentScore:(NSNumber *)currentScore;

@end
