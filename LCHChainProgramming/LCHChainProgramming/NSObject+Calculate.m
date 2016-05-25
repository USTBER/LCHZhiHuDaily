//
//  NSObject+Calculate.m
//  LCHChainProgramming
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSObject+Calculate.h"

@implementation NSObject (Calculate)

+ (int)makeCalculate:(CalculateBlock)block {
    
    CalculateMaker *make = [[CalculateMaker alloc] init];
    block(make);
    
    return make.result;
}

@end
