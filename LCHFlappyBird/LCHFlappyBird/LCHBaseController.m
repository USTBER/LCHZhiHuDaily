//
//  LCHBaseController.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHBaseController.h"

@interface LCHBaseController ()

@property (nonatomic, strong) UIImageView *backGroundView;


@end

@implementation LCHBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backGroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (BOOL)shouldAutorotate {
    
    return false;
}


- (UIImageView *)backGroundView {
    
    if (_backGroundView) {
        
        return _backGroundView;
    }
    _backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backGroundView.image = [UIImage imageNamed:@"bg.png"];
    
    return _backGroundView;
}

- (LCHGameInfo *)gameInfo {
    
    if (_gameInfo) {
        
        return _gameInfo;
    }
    _gameInfo = [LCHGameInfo sharedGameInfo];
    
    return _gameInfo;
}



@end
