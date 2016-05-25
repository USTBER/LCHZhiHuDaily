//
//  LCHURLParse.h
//  LCHHttpClientParse
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCHGlobal.h"

@interface LCHURLParse : NSObject

+ (instancetype)sharedURLParse;

- (NSDictionary *)paramterFromURL:(NSURL *)url;

@end
