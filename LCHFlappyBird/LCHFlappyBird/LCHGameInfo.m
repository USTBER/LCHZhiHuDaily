//
//  LCHGameInfo.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHGameInfo.h"
#import "Common.h"

static NSString *const kTopFiveScoreKey = @"topFiveScoreKey";

static LCHGameInfo *sharedGameInfo;
@implementation LCHGameInfo

+ (instancetype)sharedGameInfo {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedGameInfo = [[super allocWithZone:nil] init];
        sharedGameInfo.gameDegree = kGameDegreeOrdinary;
    });
    
    return sharedGameInfo;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedGameInfo];
    
}

- (void)updateTopFiveScoreWithScore:(NSNumber *)score {
    
    int count = (int)self.topFiveScore.count;
    
    for (int i = 0; i < count; i++) {
        if (score >= self.topFiveScore[i]) {
            
            for (int j = count - 2; j >= i; j--) {
                
                [self.topFiveScore replaceObjectAtIndex:j + 1 withObject:self.topFiveScore[j]];
                
            }
            [self.topFiveScore replaceObjectAtIndex:i withObject:score];

            [[NSUserDefaults standardUserDefaults] setObject:self.topFiveScore forKey:kTopFiveScoreKey];
            break;
        }
    }
    
}


- (NSArray *)gameDegrees {
    
    if (_gameDegrees) {
        
        return _gameDegrees;
    }
    _gameDegrees = @[@"crazy", @"hard", @"difficult", @"general", @"ordinary"];
    
    return _gameDegrees;
}

- (NSMutableArray *)topFiveScore {
    
    if (_topFiveScore) {
        
        return _topFiveScore;
    }
    NSArray *tem = [[NSUserDefaults standardUserDefaults] arrayForKey:kTopFiveScoreKey];
    _topFiveScore = [[NSMutableArray alloc] initWithArray:tem copyItems:YES];
    for (NSUInteger i = 5 - tem.count; i > 0; i --) {
        [_topFiveScore addObject:@0];
    }
    
    return _topFiveScore;
}

- (NSArray *)pipeGaps {
    
    if (_pipeGaps) {
        
        return _pipeGaps;
    }
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [temp addObject:@(kGameControllerPipGaps[i] * height)];
    }
    _pipeGaps = [[NSArray alloc] initWithArray:temp copyItems:YES];
    
    return _pipeGaps;
}

@end
