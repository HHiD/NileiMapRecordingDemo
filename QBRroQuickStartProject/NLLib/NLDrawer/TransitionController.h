//
//  TransitionController.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionController : NSObject<UIViewControllerInteractiveTransitioning>

- (instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)animator;


@property (nonatomic, readonly) CGFloat duration;

@property (readonly)            CGFloat percentComplete;

@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning>animator;

@property (nonatomic, readonly) CGFloat completionSpeed;

/**
 *  protocol
 */
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

- (BOOL)isInteracting;

@end


