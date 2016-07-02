//
//  LCHThemeNewsTool.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHThemeNewsTool : NSObject

@property (nonatomic, strong) NSMutableArray *newsIDs;

+ (id)sharedThemeNewsTool;

- (NSString *)nextNewsID:(NSString *)currentNewsID;
- (NSString *)formmerNewsID:(NSString *)currentNewsID;
- (BOOL)isFirstNews:(NSString *)currentNewsID;
- (BOOL)isLastNews:(NSString *)currentNewsID;

@end
