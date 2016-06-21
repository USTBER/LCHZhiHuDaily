//
//  LCHHomePageNewsModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHHomePageNewsModel : NSObject

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger newsID;
@property (nonatomic, strong) NSString *ga_prefix;
@property (nonatomic, strong) NSString *title;

@end
