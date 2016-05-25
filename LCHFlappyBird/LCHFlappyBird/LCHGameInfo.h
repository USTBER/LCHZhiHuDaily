//
//  LCHGameInfo.h
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GameDegree) {
    kGameDegreeCrazy = 0,
    kGameDegreeHard,
    kGameDegreeDifficult,
    kGameDegreeGeneral,
    kGameDegreeOrdinary
};

@interface LCHGameInfo : NSObject

@property (nonatomic, copy) NSMutableArray *topFiveScore;
@property (nonatomic, copy) NSArray *gameDegrees;
@property (nonatomic, assign) GameDegree gameDegree;
@property (nonatomic, copy) NSArray *pipeGaps;

+ (instancetype)sharedGameInfo;

- (void)updateTopFiveScoreWithScore:(NSNumber *)score;

@end
