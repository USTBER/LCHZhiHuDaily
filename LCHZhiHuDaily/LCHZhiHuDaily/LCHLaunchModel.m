//
//  LCHLaunchModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLaunchModel.h"

@implementation LCHLaunchModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"launchTitle" : @"text",
             @"launchImageURL" : @"img"};
}

@end
