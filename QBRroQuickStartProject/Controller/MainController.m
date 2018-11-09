//
//  MainController.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "MainController.h"
#import "AppContainerTransition.h"
#import "RunningController.h"

@interface MainController () {
    MainView *_mainView;
}

@end

@implementation MainController


- (void)viewDidLoad {
    [super viewDidLoad];
    _mainView = [MainView new];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    _mainView.frame = self.view.bounds;
}


#pragma - mark MainView delegate
- (void)didUserCenterTouched {
    [AppContainerTransition moveToUserCenter];
}

- (void)didStartRunningTouched {
    RunningController *running = [[RunningController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:running];
    [self presentViewController:navi animated:YES completion:nil];
}
@end
