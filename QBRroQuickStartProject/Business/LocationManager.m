//
//  LocationManager.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "LocationManager.h"
#import <MapKit/MKGeometry.h>
#import "EntityManager.h"
#import "RRCoordCover.h"
#import <UIKit/UIKit.h>
#import "RunnerStep.h"

#define kStartTime @"markStartTime"
#define kTotalTime @"markTotalTime"
#define kCashUploadLocationTime @"cashUploadLocationTime"
#define kBroadcastMillstone     500

@implementation LocationManager {
    CLLocationManager           *_locationManager;
    //用于开始后退任务上传坐标
    UIBackgroundTaskIdentifier  _backgroundTask;
    CLLocationCoordinate2D      _preCoordinate;
    RunnerBroadcast             *_runnerBroadcast;
}

- (id)init {
    self             = [super init];
    _runnerCourse    = [RunnerCourse new];
    _runnerBroadcast = [RunnerBroadcast new];
    _runnerBroadcast.delegate = self;
    return self;
}

- (void)startLocationManager {
    int distance = 2;
//    NSLog(@"ioslocatedistance #### %d",distance);
    _locationManager                 = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _locationManager.delegate        = self;
    _locationManager.distanceFilter  = distance;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager setAllowsBackgroundLocationUpdates:YES];
}


- (void)recordUserLocation:(RunnerStep*)runner {
    UIApplication *application = [UIApplication sharedApplication];
    UIApplicationState state   = application.applicationState;
    if (state==UIApplicationStateActive) {
        [self handleWithNewCoordinate:runner];
    }
    else {
        if (_backgroundTask != UIBackgroundTaskInvalid) {
//            [_seesionTask cancel];
        }
        else {
            _backgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
                [self endBacgroundTask];
            }];
        }
        [self handleWithNewCoordinate:runner];
    }
}


- (void)endBacgroundTask {
    if (_backgroundTask != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
        _backgroundTask = UIBackgroundTaskInvalid;
    }
}

- (void)broadcastWithNewStep:(RunnerStep*)runner {
    double f1 = _runnerCourse.runningDistance;
    double distance    = _runnerCourse.runningDistance/kBroadcastMillstone;
    [_runnerCourse addNiewRunnerStep:runner];
    double f2 =  _runnerCourse.runningDistance;
    double newDistance = _runnerCourse.runningDistance/kBroadcastMillstone;
    if (floor(distance)<floor(newDistance)) {
//        NSLog(@"播报广播 distance=%.5f  newDistance=%.5f",distance,newDistance);
        double floorValue = floor(newDistance);
        NSString *txt = [NSString stringWithFormat:@"您已经跑了%d公里 加油 加油 加 加油",(int)floorValue];
        [_runnerBroadcast broadcastWithString:txt];
    }
    else {
        NSLog(@"####### distance=%.5f  newDistance=%.5f",f1,f2);
         [self endBacgroundTask];
    }
}


//app被用户杀死，记录这个行为
- (void)didUserKillApplication {
    if (_backgroundTask != UIBackgroundTaskInvalid) {
    }
    else {
        UIApplication *application = [UIApplication sharedApplication];
        _backgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
            [self endBacgroundTask];
        }];
    }

}


#pragma mark -

- (void)handleWithNewCoordinate:(RunnerStep*)runner {
    //5号newCacheLocation   6号 leiLocation
    /*
     * TO - DO this function will be compelet in the next version ,use data base to persistence runner location data
     *
     */
    [self broadcastWithNewStep:runner];
}







#pragma mark - public methods
- (void)pauseToRecordRunnerTrace {
    [_locationManager stopUpdatingLocation];
    NSLog(@"暂停定位");
}

- (void)resumeToRecordRunnerTrace {
    [_locationManager startUpdatingLocation];
    NSLog(@"重新开始定位");
}

- (void)beginRecordingRunnerNewTrace {
    _runnerCourse = [RunnerCourse new];
    [_locationManager startUpdatingLocation];
    
}

-(void)finishRunning {
    [_locationManager stopUpdatingLocation];
    [EntityManager testMethodTemporarySaveRunnerStep:_runnerCourse];
    _runnerCourse = [RunnerCourse new];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (locations.count>0) {
        CLLocation *newLocation = [locations lastObject];
        CLLocationCoordinate2D coord = [RRCoordCover convertWGSToGCJ02:newLocation.coordinate];
        if (_preCoordinate.latitude==0.0) {
            _preCoordinate = coord;
        }
        else {
            MKMapPoint newPoint = MKMapPointForCoordinate(coord);
            MKMapPoint oldPoint = MKMapPointForCoordinate(_preCoordinate);
            CLLocationDistance distance = MKMetersBetweenMapPoints(newPoint, oldPoint);
            RunnerStep *runnerStep  = [[RunnerStep alloc] initRunnerStepWith:newLocation];
            runnerStep.speed        = newLocation.speed;
            runnerStep.distance     = distance;
            runnerStep.timestamp    = newLocation.timestamp.timeIntervalSince1970;
            runnerStep.course       = newLocation.course;
            [self recordUserLocation:runnerStep];
            _preCoordinate = coord;
        }
    }
}

#pragma mark - RunnerBroadcastDelegate

- (void)didFinishRunnerBroadcast {
    [self endBacgroundTask];
}

@end
