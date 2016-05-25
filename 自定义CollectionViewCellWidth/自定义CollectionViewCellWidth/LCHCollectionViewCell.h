//
//  LCHCollectionViewCell.h
//  自定义CollectionViewCellWidth
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHCollectionViewCellDelegate.h"

@interface LCHCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, weak) id<LCHCollectionViewCellDelegate> delegate;

@end
