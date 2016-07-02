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
#import "LCHThemeNewsTool.h"
#import "LCHLeafController.h"

@interface LCHThemeDetailNewsController ()
<LCHThemeDetailNewsViewDataSource, LCHRecommendersViewDataSource, LCHThemeDetailNewsViewDelegate, LCHRecommendersViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) LCHThemeDetailNewsView *detailNewsView;
@property (nonatomic, strong) LCHThemeDetailNewsModel *themeDetailNewsModel;
@property (nonatomic, strong) LCHThemeNewsTool *tool;
@property (nonatomic, strong) UIApplication *sharedApplication;

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
    self.sharedApplication = [UIApplication sharedApplication];
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
    
    if (!self.newsID) {
        
        return;
    }
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
        //        [self.view setNeedsLayout];
        //        [self.view layoutIfNeeded];
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
    
    return [self.tool isFirstNews:self.newsID];
}

- (BOOL)isLastNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    return [self.tool isLastNews:self.newsID];
}

#pragma mark - LCHThemeDetailNewsViewDelegate

- (void)loadFormmerNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    NSString *formmerNewsID = [self.tool formmerNewsID:self.newsID];
    if (!formmerNewsID) {
        
        return;
    }
    [self.delegate scrollToFormmerNews:formmerNewsID];
}

- (void)loadNextNews:(LCHThemeDetailNewsView *)detailNewsView {
    
    NSString *nextNewsID = [self.tool nextNewsID:self.newsID];
    if (!nextNewsID) {
        
        return;
    }
    [self.delegate scrollToNextNews:nextNewsID];
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
    
    
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    
    CGFloat height = [height_str floatValue];
    NSLog(@"in origin height is %f", height);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.detailNewsView resetFooterConstraints:height];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"error! happened in %s in domian %@", __func__, error.domain);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    
    NSString *str = request.URL.absoluteString;
    
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        str = [str stringByReplacingOccurrencesOfString:@"myweb:imageClick:"
                                             withString:@""];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
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

- (LCHThemeNewsTool *)tool {
    
    if (_tool) {
        
        return _tool;
    }
    _tool = [LCHThemeNewsTool sharedThemeNewsTool];
    
    return _tool;
    
}

- (UIApplication *)sharedApplication {
    
    if (_sharedApplication) {
        
        return _sharedApplication;
    }
    _sharedApplication = [UIApplication sharedApplication];
    
    return _sharedApplication;
}

@end
