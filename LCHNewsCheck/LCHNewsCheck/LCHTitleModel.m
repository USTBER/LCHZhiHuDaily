//
//  LCHTitleModel.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHTitleModel.h"

static LCHTitleModel *titleModal;

@interface LCHTitleModel ()

@property (nonatomic, copy) NSArray *newsColumns;
@property (nonatomic, copy) NSMutableArray *cellWidths;


@end

@implementation LCHTitleModel

#pragma mark - overWirte

+ (instancetype)defaultTitleModal {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        titleModal = [[super allocWithZone:nil] init];
    });
    
    return titleModal;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self defaultTitleModal];
}

#pragma mark - lazyloading

- (NSArray *)newsColumns {
    
    if (_newsColumns) {
        
        return _newsColumns;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NewsColumns" ofType:@"plist"];
    _newsColumns = [[NSArray alloc] initWithContentsOfFile:path];
    if (!_newsColumns) {
        LCH_LOG_NULL_ERROR;
    }
    
    return _newsColumns;
}

- (NSMutableArray *)cellWidths {
    
    if (_cellWidths) {
        
        return _cellWidths;
    }
    _cellWidths = [[NSMutableArray alloc] init];
    
    for (int i=0; i < self.newsColumns.count; i++) {
        
        [_cellWidths addObject:@0];
    }
    
    return _cellWidths;
}

@end
