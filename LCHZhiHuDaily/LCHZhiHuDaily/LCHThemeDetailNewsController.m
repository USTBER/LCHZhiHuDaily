//
//  LCHThemeDetialNewsController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeDetailNewsController.h"
#import "LCHThemeDetailNewsConfig.h"
#import "LCHThemeDetailNewsView.h"
#import "LCHThemeDetailNewsModel.h"
#import "LCHRecommenders.h"
#import "AppDelegate.h"

@interface LCHThemeDetailNewsController ()
<LCHThemeDetailNewsViewDataSource, LCHRecommendersViewDataSource, LCHThemeDetailNewsViewDelegate, LCHRecommendersViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) LCHThemeDetailNewsView *detailNewsView;
@property (nonatomic, strong) LCHThemeDetailNewsModel *themeDetailNewsModel;

- (void)configConstraints;
- (void)getThemeData;

@end

@implementation LCHThemeDetailNewsController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.detailNewsView];
    [self configConstraints];
    [self getThemeData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)dealloc {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    [self.detailNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.offset(0);
    }];
}

- (void)getThemeData {
    
    [LCHDataManager getThemeDetailNews:[kThemeDetailNewsAPI stringByAppendingString:self.newsID] success:^(id returnModel) {
        
        self.themeDetailNewsModel = returnModel;
        NSInteger recommendersCount = self.themeDetailNewsModel.recommenders.count;
        
        self.detailNewsView.viewType = DetailNewsViewWithNothing;
        if (self.themeDetailNewsModel.image && recommendersCount > 0) {
            self.detailNewsView.viewType = DetailNewsViewWithImageAndRecommends;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            if (self.themeDetailNewsModel.image) {
                self.detailNewsView.viewType = DetailNewsViewWithImage;
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                
            }
            if (recommendersCount > 0) {
                self.detailNewsView.viewType = DetailNewsViewWithRecommends;
            }
        }
        [self.detailNewsView reloadData];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        [self.view setNeedsDisplay];
    } failed:^(NSError *error) {
        
    }];
    
}

#pragma mark - LCHThemeDetailNewsViewDataSource

- (NSString *)topHeadImageURL:(LCHThemeDetailNewsView *)detailNewsView {
    
    return self.themeDetailNewsModel.image;
}

- (NSString *)topHeadSourceLableText:(LCHThemeDetailNewsView *)detailNewsView {
    
    return self.themeDetailNewsModel.image_source;
}

- (NSString *)topHeadTitleLabelText:(LCHThemeDetailNewsView *)detailNewsView {
    
    return self.themeDetailNewsModel.title;
}

- (NSString *)webURL:(LCHThemeDetailNewsView *)detailNewsView {
    
    return self.themeDetailNewsModel.htmlURL;
}

- (BOOL)isFirstNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    return NO;
}

- (BOOL)isLastNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    return NO;
}

#pragma mark - LCHThemeDetailNewsViewDelegate

- (void)loadFormmerNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    [self.delegate scrollToFormmerNews:@"7116244"];
}

- (void)loadNextNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    [self.delegate scrollToNextNews:@"7116244"];
}

#pragma mark - LCHRecommendersViewDataSource

- (NSInteger)numberOfRecommenders:(LCHRecommendersView *)recommendersView {
    
    return self.themeDetailNewsModel.recommenders.count;
}

- (NSString *)recommenderView:(LCHRecommendersView *)recommendersView imageURLForIndex:(NSInteger)index {
    
    LCHRecommenders *recommender = self.themeDetailNewsModel.recommenders[index];
    
    return recommender.avatar;
}

#pragma mark - LCHRecommendersViewDelegate

- (void)recommenderView:(LCHRecommendersView *)recommendersView didSelectRecommenderAtIndex:(NSInteger)index {
    
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    CGFloat height = [height_str floatValue];
    [self.detailNewsView resetFooterConstraints:height];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"error! happened in %s in domian %@", __func__, error.domain);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return YES;
    
}

#pragma mark - lazy loading

- (LCHThemeDetailNewsView *)detailNewsView {
    
    if (_detailNewsView){
        
        return _detailNewsView;
    }
    _detailNewsView = [[LCHThemeDetailNewsView alloc] init];
    _detailNewsView.delegate = self;
    _detailNewsView.dataSource = self;
    _detailNewsView.webView.delegate = self;
    _detailNewsView.recommendersView.delegate = self;
    
    return _detailNewsView;
}

- (LCHThemeDetailNewsModel *)themeDetailNewsModel {
    
    if (_themeDetailNewsModel) {
        
        return _themeDetailNewsModel;
    }
    _themeDetailNewsModel = [[LCHThemeDetailNewsModel alloc] init];
    
    return _themeDetailNewsModel;
}


@end
