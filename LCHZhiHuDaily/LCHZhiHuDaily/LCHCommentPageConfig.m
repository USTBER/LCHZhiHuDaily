//
//  LCHCommentPageConfig.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCommentPageConfig.h"

@implementation LCHCommentPageConfig

NSString *const kLongCommentAPI = @"http://news-at.zhihu.com/api/4/story/%@/long-comments";
NSString *const kShortCommentAPI = @"http://news-at.zhihu.com/api/4/story/%@/short-comments";
NSString *const kCommentCellReuseIdentifier = @"commentCellReuseIdentifier";

NSString *const kCommentBottomBarBackgroundImage = @"Browser_Toolbar";

NSString *const kCommentBottomBarBackButtonImage = @"Comment_Icon_Back";
NSString *const kCommentBottomBarWriteIconImage = @"Comment_Icon_Compose";
NSString *const kCommentBottomBarWriteLabelText = @"写评论";

CGFloat const kCommentBottomBarWriteLabelFontSize = 10;
CGFloat const kCommentBottomBarWriteIconWidth = 20;
CGFloat const kCommentBottomBarWriteIconHeight = 20;

CGFloat const kCommentTopBarHeight = 60;
CGFloat const kCommentBottomBarHeight = 40;

CGFloat const kCommentPageNoCommentLabelFontSize = 12;
CGFloat const kCommentPageNoCommentLabelTopPadding = 20;

CGFloat const kCommentPageNoCommentImageViewTopPadding = 130;
CGFloat const kCommentPageNoCommentImageViewWidth = 150;
CGFloat const kCommentPageNoCommentImageViewHeight = 150;
NSString *const kCommentPageNoCommentImageViewImageName = @"Comment_Empty";

CGFloat const kCommentPageViewWithLongCommentHeight = 35;
CGFloat const kCommentPageViewWithOutLongCommentHeight = 420;

NSString *const kCommentPageDispalyCellReuseIdentifier = @"commentPageDispalyCellReuseIdentifier";

CGFloat const kCommentPageLongCommentNumberLabelFontSize = 15;
NSString *const kCommentPageLongCommentNumberLabelText = @"%ld 条长评";
CGFloat const kCommentPageLongCommentNumberLabelLeftPadding = 10;

@end
