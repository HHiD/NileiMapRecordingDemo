//
//  UIViewController+StatuBarStyle.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "UIViewController+StatuBarStyle.h"
#import <objc/runtime.h>

@implementation UIViewController (StatuBarStyle)
+(void)load {
    Method oldHidden = class_getInstanceMethod([self class], NSSelectorFromString(@"prefersStatusBarHidden")),
    newHidden = class_getInstanceMethod([self class], @selector(prefersStatusBarHiddenCustom));
    method_exchangeImplementations(oldHidden, newHidden);
    
    Method oldStyle = class_getInstanceMethod([self class], NSSelectorFromString(@"preferredStatusBarStyle")),
    newStyle = class_getInstanceMethod([self class], @selector(preferredStatusBarStyleCustom));
    method_exchangeImplementations(oldStyle, newStyle);
}

- (BOOL)prefersStatusBarHiddenCustom {
    
    
    return self.isStatusBarHidden;
    
}

-(UIStatusBarStyle)preferredStatusBarStyleCustom{
    
    return self.statusBarStyle;
    
}



-(UIStatusBarStyle)statusBarStyle {
    
    UIStatusBarStyle ret = {0};
    [objc_getAssociatedObject(self, @selector(statusBarStyle)) getValue:&ret];
    return ret;
}

-(void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    
    NSValue *valueObj = [NSValue valueWithBytes:&statusBarStyle objCType:@encode(UIStatusBarStyle)];
    objc_setAssociatedObject(self, @selector(statusBarStyle), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isStatusBarHidden{
    
    BOOL ret = {0};
    [objc_getAssociatedObject(self, @selector(isStatusBarHidden)) getValue:&ret];
    return ret;
    
}


-(void)setIsStatusBarHidden:(BOOL)isStatusBarHidden {
    
    NSValue *valueObj = [NSValue valueWithBytes:&isStatusBarHidden objCType:@encode(BOOL)];
    objc_setAssociatedObject(self, @selector(isStatusBarHidden), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
