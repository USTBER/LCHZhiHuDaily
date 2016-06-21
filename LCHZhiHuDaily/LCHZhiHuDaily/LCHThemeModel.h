//
//  LCHThemeModel.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHThemeModel : NSObject

@property (nonatomic, assign) NSInteger color;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *themeDescription;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger themeID;

@end
