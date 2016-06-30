//
//  LCHDetailNewsModel.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHDetailNewsModel.h"

@implementation LCHDetailNewsModel

+ (NSDictionary *)modelCustomPropertyMapper {
        
    return @{@"newsID" : @"id"
             };
}

- (void)setCss:(NSMutableArray *)css {
    
    _css = css;
    
    if (_body) {
        _htmlURL = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",css[0], _body];
    }
}

- (void)setBody:(NSString *)body {
    
    _body = body;
    
    if (_css) {
        
        _htmlURL = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",_css[0], _body];
    }
}

@end
