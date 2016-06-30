//
//  LCHThemeContainController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeContainController.h"
#import "LCHThemeDetailNewsController.h"
#import "LCHConsoleBar.h"
#import "LCHNewsExtraData.h"
#import "LCHConsoleBarConfig.h"
#import "AppDelegate.h"

@interface LCHThemeContainController ()
<UIScrollViewDelegate, LCHThemeDetailNewsControllerDelegate, LCHConsoleBarDelegate, LCHConsoleDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LCHThemeDetailNewsController *themeDetailNewsController;
@property (nonatomic, strong) LCHConsoleBar *consoleBar;
@property (nonatomic, strong) LCHNewsExtraData *newsExtraData;

- (void)configConstraints;
- (void)getNewsExtraData;


- (LCHThemeDetailNewsController *)configThemeDetailNewsController;
- (void)setContentOffset:(CGFloat)number;

@end

@implementation LCHThemeContainController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    self.themeDetailNewsController = [self configThemeDetailNewsController];
    
    [self addChildViewController:self.themeDetailNewsController];
    [self.scrollView addSubview:self.themeDetailNewsController.view];
    
    [self.view insertSubview:self.consoleBar aboveSubview:self.scrollView];
    
    [self configConstraints];
    [self getNewsExtraData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)dealloc {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [delegate.mainViewController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - privte method

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

- (LCHThemeDetailNewsController *)configThemeDetailNewsController {
    
    LCHThemeDetailNewsController *themeDetailNewsController = [[LCHThemeDetailNewsController alloc] init];
    themeDetailNewsController.delegate = self;
    themeDetailNewsController.newsID = self.newsID;
    
    themeDetailNewsController.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    
    return themeDetailNewsController;
}

- (void)setContentOffset:(CGFloat)number {
    
        LCHThemeDetailNewsController *dvc = [self configThemeDetailNewsController];
    
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, number * kScreenHeight);
        } completion:^(BOOL finished) {
            [self.themeDetailNewsController removeFromParentViewController];
            [self.themeDetailNewsController.view removeFromSuperview];
            self.themeDetailNewsController = nil;
            self.scrollView.contentOffset = CGPointMake(0, kScreenHeight);
            self.themeDetailNewsController = dvc;
            [self.scrollView addSubview:self.themeDetailNewsController.view];
            [self addChildViewController:self.themeDetailNewsController];
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


#pragma mark - UIScrollViewDelegate

#pragma mark - LCHThemeDetailNewsControllerDelegate

- (void)scrollToFormmerNews:(NSString *)newsID {
    
    self.newsID = newsID;
    [self setContentOffset:0.f];
}

- (void)scrollToNextNews:(NSString *)newsID {
    
    self.newsID = newsID;
    [self setContentOffset:2.f];

}

#pragma mark - lazy loading

- (UIScrollView *)scrollView {
    
    if (_scrollView) {
        
        return _scrollView;
    }
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.view.bounds;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 3);
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

- (LCHConsoleBar *)consoleBar {
    
    if (_consoleBar) {
        
        return _consoleBar;
    }
    _consoleBar = [[LCHConsoleBar alloc] init];
    _consoleBar.delegate = self;
    _consoleBar.dataSource = self;
    
    return _consoleBar;
}

@end
