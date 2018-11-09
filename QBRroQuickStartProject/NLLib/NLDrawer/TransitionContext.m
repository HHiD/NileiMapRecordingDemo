//
//  TransitionContext.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "TransitionContext.h"



@implementation TransitionContext

- (instancetype)initWithFromController:(UIViewController *)fromController
                          toController:(UIViewController *)toController
{
    if (self = [super init]) {
        _containerView     = fromController.view.superview;
        _presentationStyle = UIModalPresentationCustom;
        _controllers       = @{UITransitionContextFromViewControllerKey:fromController,
                               UITransitionContextToViewControllerKey:toController, };
        
        _fromControllerStartRect = _toControllerEndRect = _containerView.bounds;
        
        _fromControllerEndRect   = CGRectOffset(_fromControllerStartRect, 100, 0);
        _fromControllerStartRect = CGRectOffset(_toControllerEndRect, -100, 0);
    }
    
    return self;
}


- (void)completeTransition:(BOOL)didComplete
{
    if (nil != _completionBlock) {
        _completionBlock(didComplete);
    }
}


- (UIViewController *)viewControllerForKey:(NSString *)key
{
    return _controllers[key];
}


- (CGRect)initialFrameForViewController:(UIViewController *)viewController
{
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return _fromControllerStartRect;
    } else {
        return _toControllerStartRect;
    }
}


- (CGRect)finalFrameForViewController:(UIViewController *)viewController
{
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return _fromControllerEndRect;
    } else {
        return _toControllerStartRect;
    }
}


- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
}


- (void)finishInteractiveTransition
{
    self.transitionWasCancelled = NO;
}


- (void)cancelInteractiveTransition
{
    self.transitionWasCancelled = YES;
}

@end

