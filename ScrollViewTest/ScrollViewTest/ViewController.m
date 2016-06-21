//
//  ViewController.m
//  ScrollViewTest
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LCHView *lchView = [[LCHView alloc] initWithFrame:self.view.bounds];
    lchView.backgroundColor = [UIColor redColor];
    [self.view addSubview:lchView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:lchView.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 2, scrollView.frame.size.height * 2);
    scrollView.backgroundColor = [UIColor yellowColor];
    
    [lchView addSubview:scrollView];
    
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height * 3);
    
    CGRect frame = scrollView.frame;
    frame.size.width -= 10;
    scrollView.frame = frame;
    
    lchView.frame = frame;

}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
