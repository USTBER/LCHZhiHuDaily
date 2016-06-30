//
//  LCHDetailNewsView.h
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHRecommendersView.h"
#import "LCHTopHeadView.h"
#import "DetailHeaderView.h"
#import "DetailFooterView.h"

typedef NS_ENUM(NSUInteger, DetailNewsViewType) {
    DetailNewsViewWithImageAndRecommends,
    DetailNewsViewWithImage,
    DetailNewsViewWithRecommends,
    DetailNewsViewWithNothing
};

@class LCHThemeDetailNewsView;

@protocol LCHThemeDetailNewsViewDataSource <NSObject>

- (NSString *)topHeadTitleLabelText:(LCHThemeDetailNewsView *)detailNewsView;
- (NSString *)topHeadImageURL:(LCHThemeDetailNewsView *)detailNewsView;
- (NSString *)topHeadSourceLableText:(LCHThemeDetailNewsView *)detailNewsView;

- (NSString *)webURL:(LCHThemeDetailNewsView *)detailNewsView;

- (BOOL)isFirstNews:(LCHThemeDetailNewsView *)detailNewsView;
- (BOOL)isLastNews:(LCHThemeDetailNewsView *)detailNewsView;

@end

@protocol LCHThemeDetailNewsViewDelegate <NSObject>

- (void)loadFormmerNews:(LCHThemeDetailNewsView *)detailNewsView;
- (void)loadNextNews:(LCHThemeDetailNewsView *)detailNewsView;

@end



@interface LCHThemeDetailNewsView : UIView

@property (nonatomic, weak) id<LCHThemeDetailNewsViewDataSource, LCHRecommendersViewDataSource> dataSource;

@property (nonatomic, weak) id<LCHThemeDetailNewsViewDelegate> delegate;

@property (nonatomic, assign)DetailNewsViewType viewType;

@property (nonatomic, readonly, strong) LCHTopHeadView *topHeadView;
@property (nonatomic, readonly, strong) LCHRecommendersView *recommendersView;
@property (nonatomic, readonly, strong) UIWebView *webView;
@property (nonatomic, readonly, strong) UILabel *firstArticleLabel;
@property (nonatomic, readonly, strong) UILabel *lastArticleLabel;
@property (nonatomic, readonly, strong) DetailHeaderView *detailHeaderView;
@property (nonatomic, readonly, strong) DetailFooterView *detailFooterView;

- (id)initWithDetailNewsType:(DetailNewsViewType)viewType frame:(CGRect)frame;

- (void)reloadData;

- (void)resetFooterConstraints:(CGFloat)height;

@end
