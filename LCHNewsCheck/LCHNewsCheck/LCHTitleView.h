//
//  LCHTitleView.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHTitleViewDelegate.h"
#import "LCHCollectionViewCell.h"

@interface LCHTitleView : UIView

@property (nonatomic, weak) id<UICollectionViewDataSource, UICollectionViewDelegate, LCHTitleViewDelegate> titleViewDelegate;

@property (nonatomic, assign) NSUInteger selectedIndex;

- (NSIndexPath *)indexPathForCollectionViewCell:(LCHCollectionViewCell *)cell;

- (void)reloadData;

@end
