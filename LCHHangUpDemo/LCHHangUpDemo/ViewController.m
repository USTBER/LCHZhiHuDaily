//
//  ViewController.m
//  LCHHangUpDemo
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHHangUpController.h"
#import "LCHPresentTransition.h"
#import "LCHDismissTransition.h"

@interface ViewController ()
<LCHHangUpControllerDelegate, UIViewControllerTransitioningDelegate>

//@property (nonatomic, strong) LCHHangUpController *hangUpController;

- (IBAction)handleDial:(id)sender;

@end

@implementation ViewController


#pragma --mark lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma --mark IBAction
- (IBAction)handleDial:(id)sender {
    
   LCHHangUpController *hangUpController = [[LCHHangUpController alloc] init];
    hangUpController.delegate = self;
    hangUpController.transitioningDelegate = self;
    hangUpController.modalPresentationStyle = UIModalPresentationCustom;

    [self presentViewController:hangUpController animated:YES completion:nil];
}


#pragma --mark LCHHangUpControllerDelegate
- (void)finishCurrentController:(UIViewController *)currentController {
    
//    [self dismissViewControllerAnimated:currentController completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma --mark UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[LCHPresentTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [[LCHDismissTransition alloc] init];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    return nil;
}


#pragma --mark lazyLoading
//- (LCHHangUpController *)hangUpController {
//    if (_hangUpController) {
//        
//        return _hangUpController;
//    }
//    _hangUpController = [[LCHHangUpController alloc] init];
//    _hangUpController.delegate = self;
//    _hangUpController.transitioningDelegate = self;
//    _hangUpController.modalPresentationStyle = UIModalPresentationCustom;
//    return _hangUpController;
//}
@end
