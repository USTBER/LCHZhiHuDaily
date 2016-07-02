//
//  LCHThemeNewsTool.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeNewsTool.h"

@interface LCHThemeNewsTool ()

@end

static LCHThemeNewsTool *sharedThemeNewsTool;

@implementation LCHThemeNewsTool

#pragma mark - life cycle

+ (id)sharedThemeNewsTool {
    
    static dispatch_once_t toolOnce;
    dispatch_once(&toolOnce, ^{
        sharedThemeNewsTool = [[super allocWithZone:nil] init];
    });
    
    return sharedThemeNewsTool;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedThemeNewsTool];
}

#pragma mark - public method

- (NSString *)formmerNewsID:(NSString *)currentNewsID {
    
    __block NSString *formmerNewsID;
    
    [self.newsIDs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *newsID = obj;
        if ([newsID isEqualToString:currentNewsID]) {
            
            if (idx == 0) {
                formmerNewsID = nil;
            } else {
                formmerNewsID =  [self.newsIDs objectAtIndex:idx - 1];
            }
        }
    }];
    
    return formmerNewsID;
}


- (NSString *)nextNewsID:(NSString *)currentNewsID {
    
   __block NSString *nextNewsID;
    
    [self.newsIDs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *newsID = obj;
        if ([newsID isEqualToString:currentNewsID]) {
            
            if (idx == self.newsIDs.count - 1) {
                nextNewsID = nil;
            } else {
                nextNewsID =  [self.newsIDs objectAtIndex:idx + 1];
            }
        }
    }];
    
    return nextNewsID;
}

- (BOOL)isFirstNews:(NSString *)currentNewsID {
    
    if (self.newsIDs.count == 0) {
        
        return YES;
    }
    NSString *firstNewsID = [self.newsIDs firstObject];
    if ([currentNewsID isEqualToString:firstNewsID]) {
        
        return YES;
    } else {
        
        return NO;
    }
}

- (BOOL)isLastNews:(NSString *)currentNewsID {
    
    if (self.newsIDs.count == 0) {
        
        return YES;
    }
    NSString *lastNewsID = [self.newsIDs lastObject];
    if ([currentNewsID isEqualToString:lastNewsID]) {
        
        return YES;
    } else {
        
        return NO;
    }
}

@end
