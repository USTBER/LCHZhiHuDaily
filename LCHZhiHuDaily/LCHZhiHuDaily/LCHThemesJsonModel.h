//
//  LCHThemesJsonModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHThemesJsonModel : NSObject

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, strong) NSMutableArray *subscribed;
@property (nonatomic, strong) NSMutableArray *others;

@end
