//
//  NLDrawerController.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "NLDrawerController.h"
#import "TransitionContext.h"
#import "TransitionAnimation.h"

@implementation NLDrawerController {
    UIViewController *_rootViewController;    //主视图控制器
    UIViewController *_curShowViewController; //当前显示视图控制器
    
    void (^_operateFinishCallBack)(void);     //视图控制器切换完成回调
}

- (instancetype)initWithRootViewController:(UIViewController *)controller
{
    if (self = [super init]) {
        [controller willMoveToParentViewController:nil];
        [self addChildViewController:controller];
        _rootViewController    = controller;
        _curShowViewController = _rootViewController;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:_curShowViewController.view];
    
    //当使用自动布局的时候_curShowViewController.view 的大小为{0,0},需要设置值
    _curShowViewController.view.frame = self.view.bounds;
}


/**
 *  状态栏样式通过显示视图控制器配置显示
 */
- (UIViewController *)childViewControllerForStatusBarStyle {
    return _curShowViewController;
}


- (void)changeRootViewController:(UIViewController *)controller {
    [self changeRootViewController:controller finishCallBack:nil];
}

-(void)changeRootViewController:(UIViewController *)controller
                     useAnimate:(id<UIViewControllerAnimatedTransitioning>)animate {
    [self changeRootViewController:controller finishCallBack:nil useAnimate:animate];
}


- (void)changeRootViewController:(UIViewController *)controller finishCallBack:(void (^)(void))cb
{
    [self changeRootViewController:controller finishCallBack:cb useAnimate:nil];
}

- (void)changeRootViewController:(UIViewController *)controller
                  finishCallBack:(void (^)(void))cb
                      useAnimate:(id<UIViewControllerAnimatedTransitioning>)animate {
    if (nil == _rootViewController ||
        nil == controller ||
        _rootViewController == controller) return;
    
    _operateFinishCallBack = [cb copy];
    
    [self _changeViewControllerFrom:_rootViewController
                                 to:controller
                       useAnimation:YES
                    completionBlock:^(BOOL isFinish) {
                        if (isFinish == true) {
                            _rootViewController = controller;
                            _curShowViewController = controller;
                        }
                    } animate:animate];
}


- (void)showChildViewController:(UIViewController *)controller
{
    [self showChildViewController:controller finishCallBack:nil];
}


- (void)showChildViewController:(UIViewController *)controller useAnimation:(BOOL)useAnimation
{
    [self showChildViewController:controller finishCallBack:nil useAnimation:useAnimation];
}


- (void)showChildViewController:(UIViewController *)controller finishCallBack:(void (^)(void))cb
{
    [self showChildViewController:controller finishCallBack:cb useAnimation:YES];
}


- (void)showChildViewController:(UIViewController *)controller
                 finishCallBack:(void (^)(void))cb
                   useAnimation:(BOOL)useAnimation
{
    if (nil == _rootViewController ||
        nil == controller ||
        _curShowViewController == controller) return;
    
    _operateFinishCallBack = [cb copy];
    
    [self _changeViewControllerFrom:_curShowViewController to:controller useAnimation:useAnimation completionBlock:^(BOOL isFinish) {
        if (isFinish) {
            _curShowViewController = controller;
        }
    }];
}


- (void)hiddenChildViewController
{
    [self hiddenChildViewControllerWithfinishCallBack:nil];
}


- (void)hiddenChildViewControllerWithfinishCallBack:(void (^)(void))cb
{
    if (nil == _rootViewController ||
        nil == _curShowViewController ||
        _curShowViewController == _rootViewController) return;
    
    _operateFinishCallBack = [cb copy];
    
    [self _changeViewControllerFrom:_curShowViewController to:_rootViewController completionBlock:^(BOOL isFinish) {
        if (isFinish) {
            _curShowViewController = _rootViewController;
        }
    }];
}


- (void)_changeViewControllerFrom:(UIViewController *)fromController to:(UIViewController *)toController
{
    [self _changeViewControllerFrom:fromController to:toController useAnimation:YES completionBlock:nil];
}


- (void)_changeViewControllerFrom:(UIViewController *)fromController to:(UIViewController *)toController completionBlock:(void (^)(BOOL))completionBlock
{
    [self _changeViewControllerFrom:fromController to:toController useAnimation:YES completionBlock:completionBlock];
}


- (void)_changeViewControllerFrom:(UIViewController *)fromController
                               to:(UIViewController *)toController
                     useAnimation:(BOOL)useAnimation
                  completionBlock:(void (^)(BOOL))completionBlock
{
    [self _changeViewControllerFrom:fromController
                                 to:toController
                       useAnimation:useAnimation
                    completionBlock:completionBlock
                            animate:nil];
    
}

- (void)_changeViewControllerFrom:(UIViewController *)fromController
                               to:(UIViewController *)toController
                     useAnimation:(BOOL)useAnimation
                  completionBlock:(void (^)(BOOL))completionBlock
                          animate:(id<UIViewControllerAnimatedTransitioning>)animate {
    if (nil == fromController || nil == toController) return;
    
    UIView *toView = toController.view;
    [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame            = self.view.frame;
    
    [fromController willMoveToParentViewController:nil];
    [self addChildViewController:toController];
    
    void (^completionBlockCopy)(BOOL) = [completionBlock copy];
    
    void (^finishChangeBlock)(void) = ^(void){
        [fromController.view removeFromSuperview];
        [fromController removeFromParentViewController];
        [toController didMoveToParentViewController:self];
        
        if (_operateFinishCallBack) {
            _operateFinishCallBack();
            _operateFinishCallBack = nil;
        }
        
        if (completionBlockCopy) {
            completionBlockCopy(YES);
        }
        
        [toController setNeedsStatusBarAppearanceUpdate];
    };
    
    void (^cancelChangeBlock)(void) = ^(void){
        [toController.view removeFromSuperview];
        
        _operateFinishCallBack = nil;
        
        if (completionBlockCopy) {
            completionBlockCopy(false);
        }
        
        [fromController setNeedsStatusBarAppearanceUpdate];
    };
    
    if (useAnimation == false) {
        [self.view addSubview:toView];
        finishChangeBlock();
        return;
    }
    
    TransitionContext *context = [[TransitionContext alloc] initWithFromController:fromController
                                                                      toController:toController];
    if (animate == nil) {//使用默认的
        animate = [[TransitionAnimation alloc] init];
    }
    
    context.containerView = self.view;
    context.animated      = YES;
    
    context.completionBlock = ^(BOOL isCompleted){
        if ([animate respondsToSelector:@selector(animationEnded:)]) {
            [animate animationEnded:isCompleted];
        }
        
        if (isCompleted) {
            finishChangeBlock();
        } else {
            cancelChangeBlock();
        }
        
        self.view.userInteractionEnabled = YES;
    };
    
    self.view.userInteractionEnabled = false;
    
    do {
        //交互模式
        
        if (![_delegate respondsToSelector:@selector(controllerForAppContainer:fromViewController:)]) break;
        
        TransitionController *interactive = [_delegate controllerForAppContainer:self fromViewController:fromController];
        
        id <UIViewControllerAnimatedTransitioning> activeAnimator = nil;
        
        if ([_delegate respondsToSelector:@selector(animatorForAppContainer:fromViewController:)]) {
            activeAnimator = [_delegate animatorForAppContainer:self fromViewController:fromController];
        }
        
        activeAnimator = activeAnimator ? activeAnimator : animate;
        
        if (interactive == nil) break;
        
//        interactive.animator = activeAnimator;
        context.interactive  = YES;
        
//        [interactive startInteractiveTransition:context];
        
        return;
    } while (0);
    
    //非交互模式
    context.interactive = NO;
    [animate animateTransition:context];
}


-(UIViewController *)currentShowViewController
{
    return _curShowViewController;
}

@end



@implementation UIViewController (NLDrawerController)

- (NLDrawerController *)containerController
{
    UIViewController *vc = self;
    
    while (vc) {
        if ([vc isKindOfClass:[NLDrawerController class]]) {
            return (NLDrawerController *)vc;
        }
        
        vc = vc.parentViewController ?: vc.presentingViewController;
    }
    
    return nil;
}

@end



