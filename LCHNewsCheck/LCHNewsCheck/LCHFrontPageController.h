//
//  LCHFrontPageController.h
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHTitleViewDelegate.h"
#import "LCHCollectionViewCellDelegate.h"

@interface LCHFrontPageController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LCHTitleViewDelegate, LCHCollectionViewCellDelegate>

@end
