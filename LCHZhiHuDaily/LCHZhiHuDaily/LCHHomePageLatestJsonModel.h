//
//  LCHHomePageLatestJsonModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHHomePageTopNewsModel.h"
#import "LCHHomePageNewsModel.h"

@interface LCHHomePageLatestJsonModel : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSMutableArray *stories;
@property (nonatomic, strong) NSMutableArray *top_stories;

@end
