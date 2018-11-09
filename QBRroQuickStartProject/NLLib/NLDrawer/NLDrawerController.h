//
//  NLDrawerController.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol NLDrawerDelegate;
@class TransitionController;

/**
 *
 *  视图控制器容器
 */
@interface NLDrawerController : UIViewController

@property (nonatomic, weak)     id<NLDrawerDelegate> delegate;
@property (nonatomic, readonly) UIViewController* currentShowViewController;
@property (nonatomic, readonly) UIViewController* rootViewController;

/**
 *  创建容器
 *
 *  @param controller 主视图控制器
 */
-(instancetype)initWithRootViewController:(UIViewController*)controller;
/**
 *  显示子视图控制器
 */
-(void)showChildViewController:(UIViewController*)controller;
-(void)showChildViewController:(UIViewController*)controller finishCallBack:(void(^)(void))cb;
-(void)showChildViewController:(UIViewController *)controller useAnimation:(BOOL)useAnimation;
/**
 *  隐藏子视图控制器
 */
-(void)hiddenChildViewControllerWithfinishCallBack:(void(^)(void))cb;
-(void)hiddenChildViewController;
/**
 *  改变根视图控制器
 */
-(void)changeRootViewController:(UIViewController*)controller;
-(void)changeRootViewController:(UIViewController *)controller
                     useAnimate:(id<UIViewControllerAnimatedTransitioning>)animate;
-(void)changeRootViewController:(UIViewController*)controller finishCallBack:(void(^)(void))cb;
@end



/**
 *
 *  视图控制器容器代理
 */
@protocol NLDrawerDelegate <NSObject>
@optional
/**
 *  获取动画控制器
 *
 *  @param container 视图控制器容器
 *  @param from      开始的视图控制器
 *
 *  @return 动画控制器
 */
-(TransitionController*)controllerForAppContainer:(NLDrawerController*)container
                               fromViewController:(UIViewController*)from;
-(id<UIViewControllerAnimatedTransitioning>)animatorForAppContainer:(NLDrawerController*)container
                                                 fromViewController:(UIViewController*)from;
@end


/**
 *
 *  基础视图控制器获取当前容器对象的扩展
 */
@interface UIViewController (NLDrawerController)

@property(nonatomic,readonly,strong) NLDrawerController* containerController; //当前视图的容器对象

@end
