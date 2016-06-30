//
//  LCHContainerController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHContainerController.h"
#import "LCHDetailNewsViewController.h"
#import "LCHConsoleBar.h"
#import "LCHConsoleBarConfig.h"
#import "LCHNewsExtraData.h"
#import "AppDelegate.h"

@interface LCHContainerController ()
<LCHConsoleBarDelegate, LCHConsoleDataSource>

@property (nonatomic, strong) LCHDetailNewsViewController *detailNewsController;
@property (nonatomic, strong) LCHConsoleBar *consoleBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LCHNewsExtraData *newsExtraData;

- (void)configConstraints;
- (void)getNewsExtraData;

@end

@implementation LCHContainerController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.detailNewsController = [[LCHDetailNewsViewController alloc] init];
    
    self.detailNewsController.newsID = self.newsID;
    [self.view addSubview:self.consoleBar];
    [self addChildViewController:self.detailNewsController];
    [self.view addSubview:self.detailNewsController.view];
    
    [self.view addSubview:self.consoleBar];
    
    [self configConstraints];
    [self getNewsExtraData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    //    [delegate.mainViewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

- (void)dealloc {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [delegate.mainViewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    [self.consoleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.offset(0);
        make.height.mas_equalTo(kConsoleBarHeight);
    }];
}

- (void)getNewsExtraData {
    
    NSString *url = [kNewsExtraDataAPI stringByAppendingString:self.newsID];
    
    [LCHDataManager getNewsExtraData:url success:^(id returnModel) {
        self.newsExtraData = returnModel;
        [self.consoleBar reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error : in domain :%@", error.domain);
    }];
}

#pragma mark - LCHConsoleBarDelegate

- (void)backToThemePage:(LCHConsoleBar *)consoleBar {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moveToNextDetailNews:(LCHConsoleBar *)consoleBar {
    
    
}

#pragma mark - LCHConsoleDataSource

- (NSInteger)numberOfAgreeFor:(LCHConsoleBar *)consoleBar {
    
    return self.newsExtraData.popularity;;
}

- (NSInteger)numberOfCommentFor:(LCHConsoleBar *)consoleBar {
    
    return self.newsExtraData.comments;
}

#pragma mark - lazy loading

//- (LCHDetailNewsViewController *)detailNewsController {
//    
//    if (_detailNewsController) {
//        
//        return _detailNewsController;
//    }
//    _detailNewsController = [[LCHDetailNewsViewController alloc] init];
//    
//    return _detailNewsController;
//    
//}

- (LCHConsoleBar *)consoleBar {
    
    if (_consoleBar) {
        
        return _consoleBar;
    }
    _consoleBar = [[LCHConsoleBar alloc] init];
    _consoleBar.delegate = self;
    _consoleBar.dataSource = self;
    
    return _consoleBar;
}

- (UIScrollView *)scrollView {
    
    if (_scrollView) {
        
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 3 * kScreenHeight);
    _scrollView.contentOffset = CGPointMake(0, kScreenHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.scrollEnabled = NO;
    
    return _scrollView;
}

- (LCHNewsExtraData *)newsExtraData {
    
    if (_newsExtraData) {
        
        return _newsExtraData;
    }
    _newsExtraData = [[LCHNewsExtraData alloc] init];
    _newsExtraData.long_comments = 0;
    _newsExtraData.popularity = 0;
    _newsExtraData.short_comments = 0;
    _newsExtraData.comments = 0;
    
    return _newsExtraData;
}

@end
