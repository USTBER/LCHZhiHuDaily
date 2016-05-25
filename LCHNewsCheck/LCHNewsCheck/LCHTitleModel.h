//
//  LCHTitleModel.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHTitleModel : NSObject

@property (nonatomic, readonly, copy) NSArray *newsColumns;

@property (nonatomic, readonly, copy) NSMutableArray *cellWidths;

+ (instancetype)defaultTitleModal;

@end
