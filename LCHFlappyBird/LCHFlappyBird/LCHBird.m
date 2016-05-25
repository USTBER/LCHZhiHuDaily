//
//  LCHBird.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHBird.h"
#import "Common.h"

@interface LCHBird ()

@property (nonatomic, strong) NSTimer *stopFlyTimer;

- (void)handleStopFly;

@end

@implementation LCHBird

- (id)init {
    
    self = [super init];
    if (self) {
        _birdSpeed = 1.f;
        _flying = NO;
        _flownPipes = 0;
        CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat mainHeight = [UIScreen mainScreen].bounds.size.height;
        _firstFrame = CGRectMake(mainWidth * kGameBirdLeftRate, mainHeight * kGameBirdTopRate, mainWidth * kGameBirdWidthRate, mainWidth * kGameBirdWidthRate);
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i = 1; i <= 3; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"bird%zi", i];
            UIImage *bird = [UIImage imageNamed:imageName];
            [temp addObject:bird];
        }
        _birdImages = [[NSArray alloc] initWithArray:temp copyItems:YES];
        [self addObserver:self forKeyPath:@"flying" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"flying"]) {
        NSNumber *flying = [change valueForKey:@"new"];
        if (flying.boolValue == YES){
            [_stopFlyTimer invalidate];
            _stopFlyTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(handleStopFly) userInfo:nil repeats:NO];
        }
    }
}

- (void)handleStopFly {
    
    _flying = NO;
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"flying" context:nil];
    [_stopFlyTimer invalidate];
}

@end
