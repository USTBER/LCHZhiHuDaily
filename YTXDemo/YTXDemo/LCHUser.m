//
//  LCHUser.m
//  YTXDemo
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHUser.h"


static LCHUser *sharedUser;
static dispatch_once_t once;

@implementation LCHUser

+ (id)sharedUser {
    
    dispatch_once(&once, ^{
        sharedUser = [[super allocWithZone:nil] init];
    });
    
    return sharedUser;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedUser];
}

@end
