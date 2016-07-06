//
//  LCHMainViewController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHMainViewController.h"
#import "LCHLaunchViewController.h"
#import "LCHHomeViewController.h"
#import "LCHThemeViewController.h"
#import "LCHLeftSideViewController.h"
#import "LCHThemeModel.h"
#import "AppDelegate.h"
#import "LCHSettingController.h"
#import "LCHMessageController.h"


#import "LCHLaunchConfig.h"


@interface LCHMainViewController ()
<LCHLeftSideDrawerDelegate>

@property (nonatomic, strong) LCHHomeViewController *homeViewController;
@property (nonatomic, strong) LCHThemeViewController *themeViewController;

@end

@implementation LCHMainViewController

#pragma life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2), dispatch_get_main_queue(), ^ {
        
        //初始化侧拉的ViewController
        LCHLeftSideViewController *leftSideViewController = [[LCHLeftSideViewController alloc] init];
        leftSideViewController.delegate = self;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
        
        navigationController.navigationBarHidden = YES;
        navigationController.navigationBar.hidden = YES;
        
        self.naviController = navigationController;
        self.leftDrawerViewController = leftSideViewController;
        self.centerViewController = navigationController;
        [self setMaximumLeftDrawerWidth:kWidth(kLeftDrawerWidth)];
        [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [self setShouldStretchDrawer:NO];
        [self setShowsShadow:NO];
        
    });
    AppDelegate *applicationDelegate = [UIApplication sharedApplication].delegate;
    applicationDelegate.mainViewController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LCHLeftSideDrawerDelegate

- (void)switchToHome {
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    navigationController.navigationBarHidden = YES;
    
    [self setCenterViewController:navigationController withCloseAnimation:YES completion:nil];
}

- (void)switchToOtherTheme:(LCHThemeModel *)themeModel {
    
    self.themeViewController.themeModel = themeModel;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.themeViewController];
    navigationController.navigationBarHidden = YES;
    
    [self setCenterViewController:navigationController withCloseAnimation:YES completion:nil];
}

- (void)switchToMessage {
    
    LCHMessageController *messageController = [[LCHMessageController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:messageController];
    navigationController.navigationBarHidden = YES;
    
    [self setCenterViewController:navigationController withCloseAnimation:YES completion:nil];
}

- (void)switchToSetting {
    
    LCHSettingController *settingController = [[LCHSettingController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingController];
    navigationController.navigationBarHidden = YES;
    
    [self setCenterViewController:navigationController withCloseAnimation:YES completion:nil];
}

#pragma mark - lazy loading

- (LCHHomeViewController *)homeViewController {
    
    if (_homeViewController) {
        
        return _homeViewController;
    }
    _homeViewController = [[LCHHomeViewController alloc] init];
    
    return _homeViewController;
}

- (LCHThemeViewController *)themeViewController {
    
    if (_themeViewController) {
        
        return _themeViewController;
    }
    
    _themeViewController = [[LCHThemeViewController alloc] init];
    
    return _themeViewController;
}

@end
