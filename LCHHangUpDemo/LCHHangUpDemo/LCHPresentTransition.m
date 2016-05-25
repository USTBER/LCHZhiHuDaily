//
//  LCHPresentTransition.m
//  LCHHangUpDemo
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHPresentTransition.h"

@implementation LCHPresentTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    CGRect frame = containerView.bounds;
    frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(120.0, 40.0, 120.0, 40.0));
    
    toViewController.view.frame = frame;
    toViewController.view.layer.borderColor = [UIColor blackColor].CGColor;
    toViewController.view.layer.borderWidth = 2.f;
    
    [containerView addSubview:toViewController.view];
    
    toViewController.view.alpha = 0.0;
    toViewController.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration / 2.0 animations:^{
        toViewController.view.alpha = 1.0;
    }];
    
    CGFloat damping = 0.55;
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:1.0 / damping options:0 animations:^{
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
