//
//  LCHDismissTransition.m
//  LCHHangUpDemo
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHDismissTransition.h"

@implementation LCHDismissTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:3.0 * duration / 4.0
                          delay:duration / 4.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromViewController.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [fromViewController.view removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
    
    [UIView animateWithDuration:2.0 * duration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:-15.0
                        options:0
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
                     }
                     completion:nil];
}

@end
