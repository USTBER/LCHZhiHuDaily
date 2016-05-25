//
//  LCHCollectionModal.h
//  自定义CollectionViewCellWidth
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHCollectionModel : NSObject

@property (nonatomic, readonly, copy) NSArray *newsTitles;
@property (nonatomic, readonly, copy) NSMutableArray *cellWidths;

+ (instancetype)defaultModal;

@end
