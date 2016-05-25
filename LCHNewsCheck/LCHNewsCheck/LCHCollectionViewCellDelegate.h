//
//  LCHCollectionViewCellDelegate.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCHCollectionViewCell;
@protocol LCHCollectionViewCellDelegate <NSObject>

- (void)currentCollectionViewCell:(LCHCollectionViewCell *)cell lableWidthDidChangeTo:(CGFloat)width;

@end
