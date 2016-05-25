//
//  NSString+LCHTrim.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSString+LCHTrim.h"

@implementation NSString (LCHTrim)

- (NSString *)trim {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
