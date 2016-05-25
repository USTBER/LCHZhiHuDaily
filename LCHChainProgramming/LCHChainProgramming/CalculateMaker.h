//
//  CalculateMaker.h
//  LCHChainProgramming
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculateMaker;
typedef CalculateMaker *(^CalculateChainBlock)(int a);

@interface CalculateMaker : NSObject

@property (nonatomic, assign) int result;

//@property (nonatomic, copy) CalculateChainBlock add;
//
//@property (nonatomic, copy) CalculateChainBlock sub;
//
//@property (nonatomic, copy) CalculateChainBlock mulit;
//
//@property (nonatomic, copy) CalculateChainBlock divide;

- (CalculateChainBlock)add;
- (CalculateChainBlock)sub;
- (CalculateChainBlock)muilt;
- (CalculateChainBlock)divide;

@end
