//
//  LCHThemeDetialNewsModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCHRecommenders.h"

@interface LCHThemeDetailNewsModel : NSObject

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *image_source;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *share_url;
@property (nonatomic, strong) NSMutableArray *js;
@property (nonatomic, strong) NSString *ga_prefix;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger newsID;
@property (nonatomic, strong) NSMutableArray *css;
@property (nonatomic, strong) NSString *htmlURL;
@property (nonatomic, strong) NSMutableArray *recommenders;

@end
