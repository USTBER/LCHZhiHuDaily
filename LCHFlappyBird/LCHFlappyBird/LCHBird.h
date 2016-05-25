//
//  LCHBird.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCHBird : NSObject

@property (nonatomic, readonly, copy) NSArray *birdImages;

@property (nonatomic, readonly, assign) CGFloat birdSpeed;

@property (nonatomic, assign, getter=isFlying) BOOL flying;

@property (nonatomic, assign) NSUInteger flownPipes;

@property (nonatomic, readonly, assign) CGRect firstFrame;

@end
