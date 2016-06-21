//
//  NSDate+LCHExpand.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDate+LCHExpand.h"

@implementation NSDate (LCHExpand)

+ (NSInteger)todayWithIntType {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString.integerValue;
}

@end
