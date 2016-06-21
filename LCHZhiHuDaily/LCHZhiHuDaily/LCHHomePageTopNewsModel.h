//
//  LCHHomePageTopNewsModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHHomePageTopNewsModel : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger newsID;
@property (nonatomic, strong) NSString *ga_prefix;
@property (nonatomic, strong) NSString *title;

@end
