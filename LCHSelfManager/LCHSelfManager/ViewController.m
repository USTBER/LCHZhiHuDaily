//
//  ViewController.m
//  LCHSelfManager
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ParentView.h"
#import "LCHButton+LCHButtonSelfManager.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) ParentView *parentView;

- (void)configConstrains;
- (void)setUpUI;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.parentView];
    [self configConstrains];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configConstrains {
    
    [self.parentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)setUpUI {
    
    [self.parentView.addStarButton setUpButtonWithNumber:5];
}


- (ParentView *)parentView {
    
    if (_parentView) {
        
        return _parentView;
    }
    _parentView = [[ParentView alloc] init];
    _parentView.backgroundColor = [UIColor greenColor];
    
    return _parentView;
}

@end
