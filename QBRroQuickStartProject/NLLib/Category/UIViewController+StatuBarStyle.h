//
//  UIViewController+StatuBarStyle.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (StatuBarStyle)

@property (nonatomic,assign) BOOL isStatusBarHidden;
@property (nonatomic,assign) UIStatusBarStyle statusBarStyle;

@end

NS_ASSUME_NONNULL_END
