//
//  LCHThemeNewsModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHThemeNewsModel : NSObject

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger newsID;

@end
