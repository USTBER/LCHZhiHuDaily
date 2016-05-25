//
//  LCHURLParse.m
//  LCHHttpClientParse
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHURLParse.h"


@implementation LCHURLParse

+ (instancetype)sharedURLParse {
    
    static LCHURLParse *sharedLCHParse;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedLCHParse = [[LCHURLParse alloc] init];
    });
    
    return sharedLCHParse;
}

- (NSDictionary *)paramterFromURL:(NSURL *)url {
    
    NSMutableDictionary *temDic = [[NSMutableDictionary alloc] init];
    [temDic setObject:url.scheme forKey:kLCHScheme];
    [temDic setObject:url.host forKey:kLCHHost];
    [temDic setObject:url.port forKey:kLCHPort];
    [temDic setObject:url.path forKey:kLCHPath];
    [temDic setObject:url.query forKey:kLCHQueryString];

    return [[NSDictionary alloc] initWithDictionary:temDic copyItems:YES];
}

@end
