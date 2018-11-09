//
//  AppContainerTransition.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "AppContainerTransition.h"
#import "UserCenterController.h"
#import "TransitionAnimation.h"
#import "NLDrawerController.h"
#import "AppDelegate.h"

@implementation AppContainerTransition

+ (void)moveToUserCenter {
    UINavigationController* nav = [[UINavigationController alloc]
                                    initWithRootViewController:[UserCenterController new]];
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.drawerController changeRootViewController:nav useAnimate:[TransitionAnimateLeftToRight new]];
}

+ (void)moveToMainController {
    id<UIViewControllerAnimatedTransitioning> animater = nil;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UINavigationController* nav = (UINavigationController*)appDelegate.drawerController.currentShowViewController;
    if ([nav isKindOfClass:[UINavigationController class]] &&
        [[nav childViewControllers].firstObject isKindOfClass:[UserCenterController class]]) {
        
        animater = [TransitionAnimateRightToLeft new];
    }
    
    
    [appDelegate.drawerController changeRootViewController:appDelegate.mainController useAnimate:animater];
    
}
@end
