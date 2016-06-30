//
//  MainViewController.m
//  MMWithoutStoryBoard
//
//  Created by apple on 16/6/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "SecondPageViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    CenterViewController *centerViewController = [[CenterViewController alloc] init];
    
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    self.naviController = naviController;
    naviController.navigationBar.hidden = YES;
    
    self.centerViewController = naviController;
    self.leftDrawerViewController = leftViewController;
    
    [self setMaximumLeftDrawerWidth:220];
    
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self setShouldStretchDrawer:NO];
    
    [self setShowsShadow:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
