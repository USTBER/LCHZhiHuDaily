//
//  ViewController.m
//  TimerTest
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"timer执行前");
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(test) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    
    NSLog(@"timer执行后");
}

@end
