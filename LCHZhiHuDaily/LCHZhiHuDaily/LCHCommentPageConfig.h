//
//  LCHCommentPageConfig.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHCommentPageConfig : UIView

UIKIT_EXTERN NSString *const kLongCommentAPI;
UIKIT_EXTERN NSString *const kShortCommentAPI;
UIKIT_EXTERN NSString *const kCommentCellReuseIdentifier;

UIKIT_EXTERN NSString *const kCommentBottomBarBackgroundImage;

UIKIT_EXTERN NSString *const kCommentBottomBarBackButtonImage;
UIKIT_EXTERN NSString *const kCommentBottomBarWriteIconImage;
UIKIT_EXTERN NSString *const kCommentBottomBarWriteLabelText;

UIKIT_EXTERN CGFloat const kCommentBottomBarWriteLabelFontSize;

UIKIT_EXTERN CGFloat const kCommentBottomBarWriteIconWidth;
UIKIT_EXTERN CGFloat const kCommentBottomBarWriteIconHeight;

UIKIT_EXTERN CGFloat const kCommentTopBarHeight;
UIKIT_EXTERN CGFloat const kCommentBottomBarHeight;

UIKIT_EXTERN CGFloat const kCommentPageNoCommentLabelFontSize;
UIKIT_EXTERN CGFloat const kCommentPageNoCommentLabelTopPadding;

UIKIT_EXTERN CGFloat const kCommentPageNoCommentImageViewTopPadding;
UIKIT_EXTERN CGFloat const kCommentPageNoCommentImageViewWidth;
UIKIT_EXTERN CGFloat const kCommentPageNoCommentImageViewHeight;
UIKIT_EXTERN NSString *const kCommentPageNoCommentImageViewImageName;

UIKIT_EXTERN CGFloat const kCommentPageViewWithLongCommentHeight;
UIKIT_EXTERN CGFloat const kCommentPageViewWithOutLongCommentHeight;

UIKIT_EXTERN NSString *const kCommentPageDispalyCellReuseIdentifier;

UIKIT_EXTERN CGFloat const kCommentPageLongCommentNumberLabelFontSize;
UIKIT_EXTERN NSString *const kCommentPageLongCommentNumberLabelText;
UIKIT_EXTERN CGFloat const kCommentPageLongCommentNumberLabelLeftPadding;

@end
