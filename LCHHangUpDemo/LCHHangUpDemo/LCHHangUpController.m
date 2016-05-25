//
//  LCHHangUpController.m
//  LCHHangUpDemo
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHangUpController.h"

@interface LCHHangUpController ()

@property (weak, nonatomic) IBOutlet UIImageView *onlineServiceImage;

- (IBAction)handleHangUp:(id)sender;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

- (void)setUpIcons;

- (void)handleTap;

@end

@implementation LCHHangUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addGestureRecognizer:self.tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpIcons {
    
    
    
}

- (void)handleTap {
    
    [self.delegate finishCurrentController:self];
}

- (IBAction)handleHangUp:(id)sender {
    
    NSLog(@"我被按下了");
}

- (UITapGestureRecognizer *)tap {
    
    if (_tap) {
        
        return _tap;
    }
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    return _tap;
}



@end
