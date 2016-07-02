//
//  LCHLeafController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLeafController.h"
#import "LCHBlackBottomBar.h"
#import "LCHLeafPageConfig.h"
#import "LCHLeafPageTopBar.h"
#import "LCHTopBarModel.h"

@interface LCHLeafController ()
<LCHBlackBottomBarDelegate, LCHLeafPageTopBarDelegate, LCHLeafPageTopBarDataSource, UIWebViewDelegate>

@property (nonatomic, strong) LCHBlackBottomBar *bottomBar;
@property (nonatomic, strong) LCHLeafPageTopBar *topBar;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) LCHTopBarModel *topBarModel;

- (void)configConstraints;

@end

@implementation LCHLeafController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.webView];
    [self configConstraints];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.offset(0);
        make.height.mas_equalTo(kHeight(kLeafPageBottomBarHeight));
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.offset(0);
        make.height.mas_equalTo(kHeight(kLeafPageTopBarHeight));
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.offset(kHeight(kLeafPageWebViewTopPadding));
        make.bottom.offset(-kHeight(kLeafPageWebViewBottomPadding));
    }];
}

#pragma mark - LCHBlackBottomBarDelegate

- (void)blackBottomBarDidPressedBackButton:(LCHBlackBottomBar *)bottomBar {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)blackBottomBarDidPressedRefreshButton:(LCHBlackBottomBar *)bottomBar {
    
    [self.webView reload];
}

- (void)blackBottomBarDidPressedShareButton:(LCHBlackBottomBar *)bottomBar {
    
    
}

#pragma mark  - LCHLeafPageTopBarDataSource

- (NSString *)titleForTopBar:(LCHLeafPageTopBar *)topBar {
    
    return self.topBarModel.topLabelText;
}

- (BOOL)shouldShowIndicatorView:(LCHLeafPageTopBar *)topBar {
    
    return self.topBarModel.showIndicator;
}

#pragma mark - LCHLeafPageTopBarDelegate

- (void)topBarDidPressBack:(LCHLeafPageTopBar *)topBar {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.topBarModel.showIndicator = YES;
    [self.topBar reloadData];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.topBarModel.topLabelText = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.topBarModel.showIndicator = NO;
    [self.topBar reloadData];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.topBarModel.topLabelText = @"加载失败!";
    self.topBarModel.showIndicator = NO;
    [self.topBar reloadData];
}

#pragma mark - lazy loading

- (LCHBlackBottomBar *)bottomBar {
    if (_bottomBar) {
        
        return _bottomBar;
    }
    _bottomBar = [[LCHBlackBottomBar alloc] init];
    _bottomBar.delegate = self;
    
    return _bottomBar;
}

- (LCHLeafPageTopBar *)topBar {
    
    if (_topBar) {
        
        return _topBar;
    }
    _topBar = [[LCHLeafPageTopBar alloc] init];
    _topBar.delegate = self;
    _topBar.dataSource = self;
    
    return _topBar;
}

- (UIWebView *)webView {
    
    if (_webView) {
        
        return _webView;
    }
    _webView = [[UIWebView alloc] init];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    
    return _webView;
}

- (LCHTopBarModel *)topBarModel {
    
    if (_topBarModel) {
        
        return _topBarModel;
    }
    _topBarModel = [[LCHTopBarModel alloc] init];
    _topBarModel.topLabelText = @"";
    _topBarModel.showIndicator = YES;
    
    return _topBarModel;
}

@end
