//
//  LCHDetailNewsViewController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHDetailNewsViewController.h"
#import "LCHTopHeadView.h"
#import "DetailHeaderView.h"
#import "DetailFooterView.h"
#import "LCHDetailNewsConfig.h"
#import "LCHDetailNewsModel.h"
#import "AppDelegate.h"

#import "LCHLeafController.h"

@interface LCHDetailNewsViewController ()
<UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *firstArticleLabel;
@property (nonatomic, strong) UILabel *lastArticleLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) LCHTopHeadView *topHeadView;
@property (nonatomic, strong) DetailHeaderView *detailHeaderView;
@property (nonatomic, strong) DetailFooterView *detailFooterView;
@property (nonatomic, strong) LCHDetailNewsModel *detailNewsModel;

- (void)configConstraints;
- (void)getDetailNewsData;
- (void)setUpData;

- (void)showFormerDetailNews;
- (void)showNextDetailNews;

@end

@implementation LCHDetailNewsViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.topHeadView addSubview:self.firstArticleLabel];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.topHeadView];
    
    //    [self.view addSubview:self.detailHeaderView];
    //    [self.view addSubview:self.detailFooterView];
    
    [self configConstraints];
    [self getDetailNewsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    if (self.topHeadView) {
        [self.webView.scrollView removeObserver:self.topHeadView forKeyPath:@"contentOffset"];
    }
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakView, self.view);
    
    [self.firstArticleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kDetailNewsFirstLabelTopPadding));
        make.centerX.offset(0);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
    }];
    
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakView);
        make.right.equalTo(weakView);
        make.top.equalTo(weakView).offset(kHeight(kDetailNewsWebViewTopPadding));
        make.bottom.equalTo(weakView).offset(-kHeight(kDetailNewsWebViewBottomPadding));
    }];
    
    [self.topHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView).offset(-kHeight(kDetailNewsTopHeadViewTopPadding));
        make.left.equalTo(weakView);
        make.right.equalTo(weakView);
        make.height.mas_equalTo(kHeight(kDetailNewsTopHeadViewHeight));
    }];
    
}

- (void)getDetailNewsData {
    
    NSString *url = [kDetailNewsAPI stringByAppendingString:self.newsID];
    [LCHDataManager getDetailNews:url success:^(id returnModel) {
        
        self.detailNewsModel = returnModel;
        [self setUpData];
        
    } failed:^(NSError *error) {
        NSLog(@"error : %@", error.domain);
    }];
}

- (void)setUpData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.webView loadHTMLString:self.detailNewsModel.htmlURL baseURL:nil];
    });
    [self.topHeadView.imageView sd_setImageWithURL:[NSURL URLWithString:self.detailNewsModel.image]];
    self.topHeadView.titleLabel.text = self.detailNewsModel.title;
    self.topHeadView.sourceLabel.text = self.detailNewsModel.image_source;
}

#pragma mark - target action

- (void)showFormerDetailNews {
    
    
}

- (void)showNextDetailNews {
    
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *str = request.URL.absoluteString;
    
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        str = [str stringByReplacingOccurrencesOfString:@"myweb:imageClick:"
                                             withString:@""];
        
        return YES;
        
    }else if ([str isEqualToString:@"about:blank"]){
        
    } else{
        LCHLeafController *leafController = [[LCHLeafController alloc] init];
        leafController.webURL = str;
        [self.navigationController pushViewController:leafController animated:YES];
        
        return NO;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    CGFloat height = [height_str floatValue];
    
    [self.webView.scrollView addSubview:self.lastArticleLabel];
    [self.lastArticleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeight(height + 30));
        make.centerX.offset(0);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self.view addSubview:self.lastArticleLabel];
    [self.lastArticleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-kHeight(kDetailNewsLastLabelBottomPadding));
        make.centerX.offset(0);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}

#pragma mark - lazy loading

- (UILabel *)firstArticleLabel {
    
    if (_firstArticleLabel) {
        
        return _firstArticleLabel;
    }
    _firstArticleLabel = [[UILabel alloc] init];
    _firstArticleLabel.textAlignment = NSTextAlignmentCenter;
    _firstArticleLabel.font = [UIFont systemFontOfSize:kDetailNewsFirstLabelFontSize];
    _firstArticleLabel.textColor = [UIColor whiteColor];
    _firstArticleLabel.text = kDetailNewsFirstLabelText;
    
    return _firstArticleLabel;
}

- (UILabel *)lastArticleLabel {
    
    if (_lastArticleLabel) {
        
        return _lastArticleLabel;
    }
    _lastArticleLabel = [[UILabel alloc] init];
    _lastArticleLabel.textAlignment = NSTextAlignmentCenter;
    _lastArticleLabel.font = [UIFont systemFontOfSize:kDetailNewsLastLabelFontSize];
    _lastArticleLabel.textColor = [UIColor redColor];
    _lastArticleLabel.text = kDetailNewsLastLabelText;
    
    return _lastArticleLabel;
}

- (UIWebView *)webView {
    
    if (_webView) {
        
        return _webView;
    }
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.opaque = NO;
    _webView.scrollView.showsVerticalScrollIndicator = YES;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.clipsToBounds = YES;
    
    return _webView;
}

- (LCHTopHeadView *)topHeadView {
    
    if (_topHeadView) {
        
        return _topHeadView;
    }
    _topHeadView = [LCHTopHeadView attachToScrollView:self.webView];
    
    return _topHeadView;
}

- (DetailHeaderView *)detailHeaderView {
    
    if (_detailHeaderView) {
        
        return _detailHeaderView;
    }
    _detailHeaderView = [DetailHeaderView attachObserveToScrollView:self.webView.scrollView target:self action:@selector(showFormerDetailNews)];
    
    return _detailHeaderView;
}

- (DetailFooterView *)detailFooterView {
    
    if (_detailFooterView) {
        
        return _detailFooterView;
    }
    _detailFooterView = [DetailFooterView attachObserveToScrollView:self.webView.scrollView target:self action:@selector(showNextDetailNews)];
    
    return _detailFooterView;
}

- (LCHDetailNewsModel *)detailNewsModel {
    
    if (_detailNewsModel) {
        
        return _detailNewsModel;
    }
    _detailNewsModel = [[LCHDetailNewsModel alloc] init];
    
    return _detailNewsModel;
}

@end
