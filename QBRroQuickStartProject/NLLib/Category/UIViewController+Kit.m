//
//  UIViewController+Kit.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "UIViewController+Kit.h"

@implementation UIViewController (Kit)

- (void)addReturnButton:(SEL)dismmiss {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 8);
    [backButton setImage:[UIImage imageNamed:@"base_icon_navbar_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:dismmiss forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

@end
