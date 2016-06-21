//
//  LCHHomePageBeforeJsonModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHomePageBeforeJsonModel.h"

@implementation LCHHomePageBeforeJsonModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"stories" : [LCHHomePageNewsModel class],
             };
}

@end
