//
//  TransitionAnimation.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "TransitionAnimation.h"

@implementation TransitionAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.alpha = 0;
                         toViewController.view.alpha = 1;
                     } completion:^(BOOL finished) {
                         fromViewController.view.alpha = 1;
                         toViewController.view.alpha = 1;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end

@implementation TransitionAnimateLeftToRight


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    CGRect tFrame = fromViewController.view.frame;
    tFrame.origin.x -= tFrame.size.width;
    toViewController.view.frame = tFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         
                         CGRect fOldFrame = fromViewController.view.frame;
                         CGRect fNewFrame = fOldFrame;
                         
                         fNewFrame.origin.x += fNewFrame.size.width;
                         fromViewController.view.frame = fNewFrame;
                         
                         toViewController.view.frame = fOldFrame;
                     } completion:^(BOOL finished) {
                         fromViewController.view.alpha = 1;
                         toViewController.view.alpha = 1;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}


@end

@implementation TransitionAnimateRightToLeft


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    CGRect tFrame = fromViewController.view.frame;
    tFrame.origin.x += tFrame.size.width;
    toViewController.view.frame = tFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         
                         CGRect fOldFrame = fromViewController.view.frame;
                         CGRect fNewFrame = fOldFrame;
                         
                         fNewFrame.origin.x -= fNewFrame.size.width;
                         fromViewController.view.frame = fNewFrame;
                         
                         toViewController.view.frame = fOldFrame;
                         
                     } completion:^(BOOL finished) {
                         fromViewController.view.alpha = 1;
                         toViewController.view.alpha = 1;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}


@end
