//
//  LCHThemeModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeModel.h"

@implementation LCHThemeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"themeDescription" : @"description",
             @"themeID" : @"id"};
}


@end
