//
//  CalculateMaker.m
//  LCHChainProgramming
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CalculateMaker.h"

@implementation CalculateMaker

- (CalculateChainBlock)add {
    
    return ^(int value) {
        
        _result += value;
        return self;
    };
}

- (CalculateChainBlock)sub {
    
    return ^(int value) {
        
        _result -= value;
        return self;
    };
}


- (CalculateChainBlock)muilt {
    
    return ^(int value) {
        
        _result *= value;
        return self;
    };
}


- (CalculateChainBlock)divide {
    
    return ^(int value) {
        
        _result /= value;
        return self;
    };
}

//- (CalculateChainBlock)add {
//    
//    if (_add) {
//        
//        return _add;
//    }
//    __weak typeof(self) weakSelf = self;
//    _add = ^(int value) {
//        
//        _result += value;
//        __strong typeof(self) strongSelf = weakSelf;
//        return strongSelf;
//    };
//    
//    return _add;
//    
//}


@end
