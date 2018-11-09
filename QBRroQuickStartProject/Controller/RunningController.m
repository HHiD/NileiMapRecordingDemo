//
//  RunningController.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunningController.h"
#import "RunnerPathController.h"
#import "RunningView.h"
#import "AppDelegate.h"

//text
#import "EntityManager.h"
#import "RunnerCourse.h"

@interface RunningController ()<RunningViewDelegate>

@property(nonatomic,strong) RunningView *runningView;

@end

@implementation RunningController {
//    RunnerCourse *course;
//    int          index;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
//    course = [EntityManager readSampleRunnerCourse];
//    index  = 0;
}

- (void)setupViews {
    _runningView = [RunningView new];
    _runningView.delegate = self;
    [self.view addSubview:_runningView];
    _runningView.frame = self.view.bounds;
    
}

- (void)dealloc {
    [_runningTimer invalidate];
    _runningTimer = nil;
}

#pragma mark - runningView delegate

- (void)pauseButtonSelected:(BOOL)paused {
    if (paused) {
        [self pause];
    }
    else {
        [self beginTimer];
    }
}

- (void)runnerFinishRunning {
    RunnerPathController *path = [RunnerPathController new];
//    RunnerStep *step = [course.steps objectAtIndex:index];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    path.runnerCourse    = app.locationManager.runnerCourse;
//    RunnerCourse *course = [EntityManager readSampleRunnerCourse];
//    path.runnerCourse    = course;
    [self.navigationController pushViewController:path animated:YES];
}

- (void)closeButtonSelected {
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - timer

//开始计时
- (void)beginTimer {
    if (!_runningTimer) {
        _interval = 0;
        _runningTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerExcute) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_runningTimer forMode:NSRunLoopCommonModes];
    }
    else {
        [self resume];
    }
}



- (void)timerExcute {
    _interval++;
    [_runningView displayRunningTime:_interval];
//    [self textWithIndex];
//    NSLog(@"_interval=%d",_interval);
}
-(void)pause {
    if (![_runningTimer isValid]) {
        return ;
    }
    [_runningTimer setFireDate:[NSDate distantFuture]];
}


-(void)resume {
    if (![_runningTimer isValid]) {
        return ;
    }
    [_runningTimer setFireDate:[NSDate date]];
}

#pragma mark- text debug
/*
- (void)textWithIndex {
    if (index<[course.steps count]) {
        RunnerStep *step = [course.steps objectAtIndex:index];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.locationManager handleWithNewCoordinate:step];
        index++;
    }
}
*/
@end
