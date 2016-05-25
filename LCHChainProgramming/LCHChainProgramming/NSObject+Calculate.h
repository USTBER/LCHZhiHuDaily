//
//  NSObject+Calculate.h
//  LCHChainProgramming
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculateMaker.h"

typedef void (^CalculateBlock)(CalculateMaker *make);

@interface NSObject (Calculate)

+ (int)makeCalculate:(CalculateBlock)block;

@end
