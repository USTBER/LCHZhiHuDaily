//
//  ViewController.m
//  LayoutSubviewsTest
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

#define _LOG_FUNC_NAME NSLog(@"%s", __func__)

@interface ViewController ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _LOG_FUNC_NAME;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    _LOG_FUNC_NAME;

}

- (void)viewDidAppear:(BOOL)animated {
    
    _LOG_FUNC_NAME;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
    _LOG_FUNC_NAME;

}

- (UIView *)redView {
    
    if (_redView) {
        
        return _redView;
    }
    _redView = [[UIView alloc] init];
    
    return _redView;
}

@end
