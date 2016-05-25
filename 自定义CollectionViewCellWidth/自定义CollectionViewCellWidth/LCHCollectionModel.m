//
//  LCHCollectionModal.m
//  自定义CollectionViewCellWidth
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCollectionModel.h"

static LCHCollectionModel *sharedModel;

@interface LCHCollectionModel ()

@property (nonatomic, copy) NSArray *newsTitles;
@property (nonatomic, copy) NSMutableArray *cellWidths;

@end

@implementation LCHCollectionModel


#pragma mark - instanceMethod

+ (instancetype)defaultModal {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedModel = [[super allocWithZone:nil] init];
    });
    return sharedModel;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self defaultModal];
}

- (NSArray *)newsTitles {
    
    if (_newsTitles) {
        
        return _newsTitles;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NewsColumns" ofType:@"plist"];
    _newsTitles = [[NSArray alloc] initWithContentsOfFile:path];
    if (!_newsTitles) {
        LCH_LOG_NULL_ERROR;
    }
    
    
    return _newsTitles;
}

- (NSMutableArray *)cellWidths {
    
    if (_cellWidths) {
        
        return _cellWidths;
    }
    _cellWidths = [[NSMutableArray alloc] init];
    
    for (int i=0; i < self.newsTitles.count; i++) {
        
        [_cellWidths addObject:@0];
    }

    
    return _cellWidths;
}

@end
