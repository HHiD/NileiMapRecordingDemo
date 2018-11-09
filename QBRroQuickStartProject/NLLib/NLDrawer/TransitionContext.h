//
//  TransitionContext.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  context transtion
 */
@interface TransitionContext : NSObject <UIViewControllerContextTransitioning> {
    NSDictionary *_controllers;
    CGRect       _fromControllerStartRect;
    CGRect       _fromControllerEndRect;
    CGRect       _toControllerStartRect;
    CGRect       _toControllerEndRect;
}

@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@property (nonatomic, assign) BOOL                     transitionWasCancelled;

//call back
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);

@property (nonatomic, assign, getter=isAnimated) BOOL animated;
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;

//transtion container
@property (nonatomic, weak) UIView *containerView;

-(instancetype)initWithFromController:(UIViewController*)fromController
                         toController:(UIViewController*)toController;

@end

