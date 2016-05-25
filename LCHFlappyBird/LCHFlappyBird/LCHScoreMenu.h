//
//  LCHScoreMenu.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHScoreMenu : UIView

- (void)showBestScore:(NSNumber *)score;
- (void)showCurrentScore:(NSNumber *)score;

@end
