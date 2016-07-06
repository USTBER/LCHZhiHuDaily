//
//  LCHShortCommentJsonModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHShortCommentJsonModel.h"
#import "LCHShortCommentModel.h"

@implementation LCHShortCommentJsonModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"comments" : [LCHShortCommentModel class],
             };
}


@end
