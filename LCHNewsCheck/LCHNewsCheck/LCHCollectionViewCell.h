//
//  LCHCollectionViewCell.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHCollectionViewCellDelegate.h"

@interface LCHCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *newsColumnName;
@property (nonatomic, weak) id<LCHCollectionViewCellDelegate> delegate;

@end
