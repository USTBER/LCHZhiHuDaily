//
//  DetailFooterView.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/24.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFooterView : UIView

+ (DetailFooterView *)attachObserveToScrollView:(UIScrollView *)scrollView
                                         target:(id)target
                                         action:(SEL)action;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com