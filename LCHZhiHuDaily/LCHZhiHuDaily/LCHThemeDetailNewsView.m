//
//  LCHDetailNewsView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeDetailNewsView.h"
#import "LCHThemeDetailNewsConfig.h"

typedef void (^ConfigConstraintsBlock)();

@interface LCHThemeDetailNewsView ()
<UIScrollViewDelegate>

@property (nonatomic, strong) LCHTopHeadView *topHeadView;
@property (nonatomic, strong) LCHRecommendersView *recommendersView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *firstArticleLabel;
@property (nonatomic, strong) UILabel *lastArticleLabel;
@property (nonatomic, strong) DetailHeaderView *detailHeaderView;
@property (nonatomic, strong) DetailFooterView *detailFooterView;

@property (nonatomic, strong) NSMutableArray *configConstraintsBlocks;

- (void)setUpSubviewsAndConstraints;
- (void)setUpData;

- (NSString *)topHeadTitleLabelTextFromDataSource;
- (NSString *)topHeadImageURLFromDataSource;
- (NSString *)topHeadSourceLableTextFromDataSource;
- (NSString *)webURLFromDataSource;
- (BOOL)isFirstNewsFromDataSource;
- (BOOL)isLastNewsFromDataSource;

- (void)handleFormmer;
- (void)handleNext;

@end

#pragma mark - life cycle

@implementation LCHThemeDetailNewsView

- (id)initWithFrame:(CGRect)frame {
    
    return [self initWithDetailNewsType:DetailNewsViewWithNothing frame:frame];
}

- (id)initWithDetailNewsType:(DetailNewsViewType)viewType frame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _viewType = viewType;
        
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        
        _topHeadView = [[LCHTopHeadView alloc] init];
        
        _recommendersView = [[LCHRecommendersView alloc] init];
        
        self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
        
        _firstArticleLabel = [[UILabel alloc] init];
        _firstArticleLabel.textAlignment = NSTextAlignmentCenter;
        _firstArticleLabel.font = [UIFont systemFontOfSize:kThemeDetailNewsFirstLabelFontSize];
        _firstArticleLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _firstArticleLabel.text = kThemeDetailNewsFirstLabelText;
        
        _lastArticleLabel = [[UILabel alloc] init];
        _lastArticleLabel.textAlignment = NSTextAlignmentCenter;
        _lastArticleLabel.font = [UIFont systemFontOfSize:kThemeDetailNewsLastLabelFontSize];
        _lastArticleLabel.textColor = [UIColor blackColor];
        _lastArticleLabel.text = kThemeDetailNewsLastLabelText;
        
        _detailHeaderView = [DetailHeaderView attachObserveToScrollView:_webView.scrollView target:self action:@selector(handleFormmer)];
        _detailFooterView = [DetailFooterView attachObserveToScrollView:_webView.scrollView target:self action:@selector(handleNext)];
    }
    
    return self;
}

- (void)dealloc {
    
    [_webView.scrollView removeObserver:_detailHeaderView forKeyPath:@"contentOffset"];
    [_webView.scrollView removeObserver:_detailFooterView forKeyPath:@"contentOffset"];
}

#pragma mark - public method

- (void)reloadData {
    
    [self setUpSubviewsAndConstraints];
    [self setUpData];
}

- (void)resetFooterConstraints:(CGFloat)height {
    
    if ([self isLastNewsFromDataSource]) {
        [_lastArticleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(height + kThemeDetailNewsLastLabelTopPadding);
        }];
    } else {
        [_detailFooterView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(height + kThemeDetailNewsDetailFooterViewlTopPadding);
        }];
    }
}

#pragma mark - private method

- (void)handleFormmer {
    
    if ([self.delegate respondsToSelector:@selector(loadFormmerNews:)]) {
        [self.delegate loadFormmerNews:self];
    }
}

- (void)handleNext {
    
    if ([self.delegate respondsToSelector:@selector(loadNextNews:)]) {
        [self.delegate loadNextNews:self];
    }
}

- (void)setUpSubviewsAndConstraints {
    
    [_webView removeFromSuperview];
    [_topHeadView removeFromSuperview];
    [_recommendersView removeFromSuperview];
    [_detailHeaderView removeFromSuperview];
    [_firstArticleLabel removeFromSuperview];
    
    ConfigConstraintsBlock block = self.configConstraintsBlocks[_viewType];
    block();
    
    [_webView.scrollView addSubview:_lastArticleLabel];
    [_webView.scrollView addSubview:_detailFooterView];
    
    [_lastArticleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(-kThemeDetailNewsDetailViewDistance);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    [_detailFooterView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-kThemeDetailNewsDetailViewDistance);
    }];
    
    if (_viewType == DetailNewsViewWithImage || _viewType == DetailNewsViewWithImageAndRecommends) {
        [_topHeadView addSubview:_firstArticleLabel];
        [_topHeadView addSubview:_detailHeaderView];
        
        [_firstArticleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.and.height.greaterThanOrEqualTo(@0.1);
            make.top.offset(kThemeDetailNewsFirstLabelInImageTopPadding);
        }];
        [_detailHeaderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(kThemeDetailNewsDetailHeaderViewInImageTopPadding);
        }];
    } else {
        [_webView.scrollView addSubview:_firstArticleLabel];
        [_webView.scrollView addSubview:_detailHeaderView];
        
        [_firstArticleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.and.height.greaterThanOrEqualTo(@0.1);
            make.top.offset(-kThemeDetailNewsFirstLabelTopPadding);
        }];
        [_detailHeaderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-kThemeDetailNewsDetailHeaderViewTopPadding);
        }];
    }
    
    if ([self isFirstNewsFromDataSource]) {
        _firstArticleLabel.hidden = NO;
        _detailHeaderView.hidden = YES;
    } else {
        _firstArticleLabel.hidden = YES;
        _detailHeaderView.hidden = NO;
    }
    
    if ([self isLastNewsFromDataSource]) {
        _lastArticleLabel.hidden = NO;
        _detailFooterView.hidden = YES;
    } else {
        _lastArticleLabel.hidden = YES;
        _detailFooterView.hidden = NO;
    }
}

- (void)setUpData {
    
    NSString *url = [self webURLFromDataSource];
    if (!url) {
        
        return;
    }
    
    [_webView loadHTMLString:url baseURL:nil];
    
    if (_viewType == DetailNewsViewWithImage || _viewType == DetailNewsViewWithImageAndRecommends) {
        
        NSString *imageURL = [self topHeadImageURLFromDataSource];
        NSString *titleLabelText = [self topHeadTitleLabelTextFromDataSource];
        NSString *sourceLabelText = [self topHeadSourceLableTextFromDataSource];
        
        [_topHeadView.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
        _topHeadView.titleLabel.text = titleLabelText;
        _topHeadView.sourceLabel.text = sourceLabelText;
    }
    
    if (_viewType == DetailNewsViewWithRecommends || _viewType == DetailNewsViewWithImageAndRecommends) {
        [_recommendersView reloadData];
    }
}

#pragma mark - data from dataSource

- (NSString *)topHeadTitleLabelTextFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(topHeadTitleLabelText:)]) {
        
        return [self.dataSource topHeadTitleLabelText:self];
    }
    return nil;
}
- (NSString *)topHeadImageURLFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(topHeadImageURL:)]) {
        
        return [self.dataSource topHeadImageURL:self];
    }
    return nil;
}
- (NSString *)topHeadSourceLableTextFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(topHeadSourceLableText:)]) {
        
        return [self.dataSource topHeadSourceLableText:self];
    }
    return nil;
}

- (NSString *)webURLFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(webURL:)]) {
        
        return [self.dataSource webURL:self];
    }
    return nil;
}

- (BOOL)isFirstNewsFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(isFirstNews:)]) {
        
        return [self.dataSource isFirstNews:self];
    }
    return nil;
}
- (BOOL)isLastNewsFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(isLastNews:)]) {
        
        return [self.dataSource isLastNews:self];
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_viewType == DetailNewsViewWithImage || _viewType == DetailNewsViewWithImageAndRecommends) {
        
        CGFloat offsetHeight = (kThemeDetailNewsViewRecommendsViewHeight);
        
        if (_viewType == DetailNewsViewWithImage) {
            offsetHeight = 0;
        }
        
        CGFloat offSetY = scrollView.contentOffset.y + offsetHeight;
        
        
        if (offSetY<=0&&offSetY>=-(90)) {
            
            [_topHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(-(45) - 0.5 * offSetY);
                make.height.mas_equalTo((265) - 0.5 * offSetY);
            }];
            
        }else if(offSetY<-(90)){
            _webView.scrollView.contentOffset = CGPointMake(0, -(90) - offsetHeight);
        }else if(offSetY <= (500)) {
            
            [_topHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(-(45) - 0.5 * offSetY);
                make.height.mas_equalTo((265) - 0.5 * offSetY);
            }];
            
            if (offSetY <= (220)) {
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            }else {
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            }
        }
    }
}

#pragma mark - lazy loading

- (NSMutableArray *)configConstraintsBlocks {
    
    if (_configConstraintsBlocks) {
        
        return _configConstraintsBlocks;
    }
    _configConstraintsBlocks = [[NSMutableArray alloc] init];
    
    ConfigConstraintsBlock blockWithNothing;
    ConfigConstraintsBlock blockWithRecommends;
    ConfigConstraintsBlock blockWithTopHead;
    ConfigConstraintsBlock blockWithBoth;
    
    WeakObject(weakSelf, self);
    WeakObject(weakWebView, _webView);
    WeakObject(weakTopHeadView, _topHeadView);
    WeakObject(weakRecommendersView, _recommendersView);
    
    blockWithNothing = ^ {
        [weakSelf addSubview:weakWebView];
        [weakWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((kThemeDetailNewsViewWebViewTopPadding));
            make.bottom.offset(-(kThemeDetailNewsViewWebViewBottomPadding));
            make.left.and.right.offset(0);
        }];
    };
    
    blockWithTopHead = ^ {
        [weakSelf addSubview:weakWebView];
        [weakSelf addSubview:weakTopHeadView];
        weakTopHeadView.hidden = NO;
        
        [weakWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((kThemeDetailNewsViewWebViewTopPadding));
            make.bottom.offset(-(kThemeDetailNewsViewWebViewBottomPadding));
            make.left.and.right.offset(0);
        }];
        [weakTopHeadView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-(kThemeDetailNewsViewTopHeadViewTopPadding));
            make.height.mas_equalTo((kThemeDetailNewsViewTopHeadViewHeight));
            make.left.and.right.offset(0);
        }];
    };
    
    blockWithRecommends = ^ {
        [weakSelf addSubview:weakWebView];
        [weakSelf addSubview:weakRecommendersView];
        [weakWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((kThemeDetailNewsViewRecommendsViewHeight + kThemeDetialNewsViewStatusBarHeight));
            make.bottom.offset(-(kThemeDetailNewsViewWebViewBottomPadding));
            make.left.and.right.offset(0);
        }];
        
        [weakRecommendersView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((kThemeDetialNewsViewStatusBarHeight));
            make.left.and.right.offset(0);
            make.height.mas_equalTo((kThemeDetailNewsViewRecommendsViewHeight));
        }];
    };
    
    blockWithBoth = ^ {
        
        [weakSelf addSubview:weakWebView];
        [weakSelf addSubview:weakTopHeadView];
        [weakWebView.scrollView addSubview:weakRecommendersView];
        
        weakTopHeadView.hidden = NO;
        
        weakWebView.scrollView.contentInset = UIEdgeInsetsMake((kThemeDetailNewsViewRecommendsViewHeight), 0, 0, 0);
        
        [weakWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((kThemeDetailNewsViewWebViewTopPadding));
            make.bottom.offset(-(kThemeDetailNewsViewWebViewBottomPadding));
            make.left.and.right.offset(0);
        }];
        
        [weakTopHeadView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-(kThemeDetailNewsViewTopHeadViewTopPadding));
            make.height.mas_equalTo((kThemeDetailNewsViewTopHeadViewHeight));
            make.left.and.right.offset(0);
        }];
        
        [weakRecommendersView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((kThemeDetailNewsViewTopHeadViewHeight - kThemeDetailNewsViewTopHeadViewTopPadding - kThemeDetailNewsViewRecommendsViewHeight - kThemeDetialNewsViewStatusBarHeight));
            make.left.and.right.offset(0);
            make.height.mas_equalTo((kThemeDetailNewsViewRecommendsViewHeight));
        }];
    };
    
    [_configConstraintsBlocks addObject:blockWithBoth];
    [_configConstraintsBlocks addObject:blockWithTopHead];
    [_configConstraintsBlocks addObject:blockWithRecommends];
    [_configConstraintsBlocks addObject:blockWithNothing];
    
    return _configConstraintsBlocks;
}

- (void)setDataSource:(id<LCHThemeDetailNewsViewDataSource,LCHRecommendersViewDataSource>)dataSource {
    
    _dataSource = dataSource;
    _recommendersView.dataSource = dataSource;
    [self reloadData];
}

@end
