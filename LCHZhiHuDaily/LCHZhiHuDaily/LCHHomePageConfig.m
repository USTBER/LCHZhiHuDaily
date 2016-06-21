//
//  LCHHomePageConfig.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHomePageConfig.h"

@implementation LCHHomePageConfig

NSString *const kHomePageLatestNewsAPI = @"http://news-at.zhihu.com/api/4/news/latest";
NSString *const KHomePageBeforeNewsAPI = @"http://news.at.zhihu.com/api/4/news/before/";

NSString *const kHomePageCellIdenfitier = @"homePageCellIdenfitier";
NSString *const kHomePageHeaderFooterViewIdenfitier = @"homePageHeaderFooterViewIdenfitier";
CGFloat const kHomePageCellHeight = 90;
CGFloat const kHomePageHeaderHeight = 30;
CGFloat const kHomePageTableSectionHeaderViewHeight = 35;
CGFloat const kHomePageTableHeaderViewHeight = 200;

CGFloat const kHomePageTitleLabelFontSize = 18;
NSString *const kHomePageTitleLabelText = @"今日新闻";
NSString *const kHomePageTMenuButtonImageName = @"Home_Icon";

CGFloat const kHomePageTableViewTopPadding = 20;
CGFloat const kHomePageTitleLabelTopPadding = 25;
CGFloat const kHomePageTitleLabelHeight = 20;

CGFloat const kHomePageRefreshWidth = 20;
CGFloat const kHomePageRefreshHeight = 20;
CGFloat const kHomePageRefreshRightPadding = 10;

CGFloat const kHomePageMenuButtonWidth = 30;
CGFloat const KHomePageMenuButtonHeight = 30;
CGFloat const KHomePageMenuButtonTopPadding = 20;
CGFloat const KHomePageMenuButtonLeftPadding = 10;

CGFloat const kHomePageCellTitleLabelFontSize = 16;
CGFloat const kHomePageCellTitleLabelTopPadding = 15;
CGFloat const kHomePageCellTitleLabelLeftPadding = 15;
CGFloat const kHomePageCellTitleLabelRightPadding = 10;

CGFloat const kHomePageCellIconImageViewTopPadding = 15;
CGFloat const kHomePageCellIconImageViewBottomPadding = 15;
CGFloat const kHomePageCellIconImageViewRightPadding = 15;
CGFloat const kHomePageCellIconImageViewWidth = 72;


CGFloat const kHomePageHeadViewTopPadding = 45;
CGFloat const kHomePageHeadViewHeight = 265;
CGFloat const kHomePageNavigationBarDefaultHeight = 55;
CGFloat const kHomePageNavigationBarHiddenHeight = 20;
@end
