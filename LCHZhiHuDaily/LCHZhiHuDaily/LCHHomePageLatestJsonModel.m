//
//  LCHHomePageLatestJsonModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHomePageLatestJsonModel.h"

@implementation LCHHomePageLatestJsonModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"stories" : [LCHHomePageNewsModel class],
             @"top_stories" : [LCHHomePageTopNewsModel class]
             };
}

@end
