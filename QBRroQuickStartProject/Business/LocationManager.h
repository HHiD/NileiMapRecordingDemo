//
//  LocationManager.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RunnerBroadcast.h"
#import "RunnerCourse.h"

@interface LocationManager : NSObject<CLLocationManagerDelegate,RunnerBroadcastDelegate>

//record the all information of a round 
@property(nonatomic,strong) RunnerCourse *runnerCourse;

- (void)startLocationManager;

- (void)handleWithNewCoordinate:(RunnerStep*)runner;
/*
 * when runner selected pause button
 */
- (void)pauseToRecordRunnerTrace;

- (void)resumeToRecordRunnerTrace;

- (void)beginRecordingRunnerNewTrace;

- (void)finishRunning;


@end

