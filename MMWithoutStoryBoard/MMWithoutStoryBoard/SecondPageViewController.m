//
//  SecondPageViewController.m
//  MMWithoutStoryBoard
//
//  Created by apple on 16/6/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SecondPageViewController.h"
#import "AppDelegate.h"

@interface SecondPageViewController ()

@end

@implementation SecondPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)dealloc{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
