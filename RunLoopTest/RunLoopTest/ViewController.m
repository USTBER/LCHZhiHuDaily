//
//  ViewController.m
//  RunLoopTest
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"

@interface ViewController ()

@property (nonatomic, strong) Dog *d1;
@property (nonatomic, weak) Dog *d2;
@property (nonatomic, unsafe_unretained) Dog *d3;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.d1 =  [[Dog alloc] init];
    self.d2 = self.d1;
    self.d3 = self.d1;
    self.d1 = nil;
    
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        sleep(10);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self logSomething];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logSomething {
    
    NSLog(@"%@", self.d1);
    NSLog(@"%@", self.d2);
    NSLog(@"%@", self.d3);
}

- (void)test {
    
    NSLog(@"没什么事儿，请不要在意！");
}

@end
