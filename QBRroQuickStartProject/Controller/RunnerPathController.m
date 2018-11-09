//
//  RunnerPathController.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunnerPathController.h"
#import "UIViewController+Kit.h"
#import "RunnerMapView.h"

@interface RunnerPathController () {
    RunnerMapView *_mainView;
}

@end

@implementation RunnerPathController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"runner path";
        [self addReturnButton:@selector(dismiss)];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mainView = [RunnerMapView new];
    [self.view addSubview:_mainView];
    _mainView.frame = self.view.bounds;
    [self drawRunnerPath];
}

- (void)drawRunnerPath {
//    _runnerCourse         = [EntityManager readSampleRunnerCourse];
    _mainView.runnerSteps = _runnerCourse.steps;
    [_runnerCourse computeTotalDistance];
    _mainView.runnerSpeedLabel.text     = [NSString stringWithFormat:@"speed:%.f m/s",_runnerCourse.runningSpeed];
    _mainView.runningDistanceLabel.text = [NSString stringWithFormat:@"run:%.f m",_runnerCourse.runningDistance];
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
