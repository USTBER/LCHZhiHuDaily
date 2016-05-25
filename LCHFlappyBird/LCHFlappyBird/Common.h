//
//  Common.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+FrameProperty.h"
#import "LCHFinishControllerDelegate.h"
#import "LCHGameOverDelegate.h"
#import "LCHBackToMenuDelegate.h"
#import "LCHSoundTool.h"

#ifndef Common_h
#define Common_h

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define WeakSelf(weakSelf) __weak typeof(self) weakSelf = self

#define kPadding ([[UIScreen mainScreen] bounds].size.height/20)

#define kTopPadding ([[UIScreen mainScreen] bounds].size.height/10)

static const CGFloat kTitleViewWidthRate = 2;
static const CGFloat kTitleViewHeightRate = 12;
static const CGFloat kBirdWidthRate = 10;
static const CGFloat kScoreMenuWidthRate = 2;
static const CGFloat kScoreMenuHeightRate = 6;
static const CGFloat kRateButtonWidthRate = 5;
static const CGFloat kRateButtonHeightRate = 12;
static const CGFloat kGameButtonWidthRate = 5;
static const CGFloat kGameButtonHeightRate = 15;
static const CGFloat kRankButtonWidthRate = 5;
static const CGFloat kRankButtonHeightRate = 15;


#pragma for LCHRateController

static NSString *const kRateCellReuseIdentifier = @"rateCell";
static const CGFloat kRateTableViewWidthRate = 1/2.f;
static const CGFloat kRateTableViewHeightRate = 3/5.f;
static const CGFloat kRateLabelWidthRate = 1.5f;
static const CGFloat kRateLabelHeightRate = 6;
#define kRateTableViewHeightPadding ([[UIScreen mainScreen] bounds].size.height/3)

#pragma for LCHRankController

static NSString *const kRankCellReuseIdentifier = @"rankCell";
static const CGFloat kRankTableViewWidthRate = 3/4.f;
static const CGFloat kRankTableViewHeightRate = 3/5.f;

#define kRankTableViewHeightPadding ([[UIScreen mainScreen] bounds].size.height/4)

#pragma for LCHGameScence

static const CGFloat kGameBirdLeftRate = 1/3.f;
static const CGFloat kGameBirdTopRate = 1/2.f;
static const CGFloat kGameBirdWidthRate = 1/10.f;

static const CGFloat kGameControllerRoadHeightRate = 1/5.f;
static const CGFloat kGameControllerRoadRightOffset = 20.f;

static const CGFloat kGameControllerPipeWidthRate = 1/10.f;

static const CGFloat kGameControllerPipGaps[] = {1/10.f, 1/9.f, 1/8.f, 1/7.f, 1/6.f};





#endif /* Common_h */
