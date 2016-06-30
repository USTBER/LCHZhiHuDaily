//
//  LCHUser.h
//  YTXDemo
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHUser : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appToken;
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *MD5Token;


+ (id)sharedUser;

@end
