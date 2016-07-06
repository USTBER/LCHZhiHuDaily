//
//  LCHLongCommentJsonModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLongCommentJsonModel.h"
#import "LCHLongCommentModel.h"

@implementation LCHLongCommentJsonModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"comments" : [LCHLongCommentModel class],
             };
}


@end
