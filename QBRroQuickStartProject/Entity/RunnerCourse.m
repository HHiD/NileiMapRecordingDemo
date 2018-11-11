//
//  RunnerCourse.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunnerCourse.h"
#import "CoordinateFilter.h"

@implementation RunnerCourse

- (id)init {
    self             = [super init];
    _steps           = [[NSMutableArray alloc] initWithCapacity:10];
    _runningDistance = 0;
    return self;
}

- (void)addNiewRunnerStep:(RunnerStep*)step {
    [self initializeFoureCoordinate:step];
    RunnerStep *lastStep = [_steps lastObject];
    MKMapPoint firstPoint  = MKMapPointForCoordinate(lastStep.coordinate);
    MKMapPoint secondPoint = MKMapPointForCoordinate(step.coordinate);
    CLLocationDistance foodStep = MKMetersBetweenMapPoints(firstPoint, secondPoint);
    if (foodStep<kRunnerStepValidRangePerSecond) {
        _runningDistance +=foodStep;
        [self compareCoordinateWithNewRunnerStep:step];
//        NSLog(@"result of foodStep = %.2f distance = %.2f ",foodStep,_runningDistance);
    }
    [_steps addObject:step];

//    _runningDistance +=step.distance;
}

/*
 * this function is aimed at find foure extrem point of all the runner coordinates
 */
- (void)compareCoordinateWithNewRunnerStep:(RunnerStep*)step {
    CLLocationCoordinate2D newCoord = step.coordinate;
    if (_topCoordinate.latitude<newCoord.latitude) {
        _topCoordinate = newCoord;
//        NSLog(@"new _topCoordinate  latitude = %f",_topCoordinate.latitude);
    }
    else if (_lowCoordinate.latitude>newCoord.latitude) {
        _lowCoordinate = newCoord;
//        NSLog(@"new _lowCoordinate  latitude = %f",_lowCoordinate.latitude);
    }
    else {
        
    }
    if (_leftCoordinate.longitude>newCoord.longitude) {
        _leftCoordinate = newCoord;
//        NSLog(@"new _leftCoordinate  longitude = %f",_leftCoordinate.longitude);
    }
    else if (_rightCoordinate.longitude<newCoord.longitude) {
        _rightCoordinate = newCoord;
//        NSLog(@"new _rightCoordinate  longitude = %f",_rightCoordinate.longitude);
    }
    else {
        
    }
}

- (void)initializeFoureCoordinate:(RunnerStep*)step {
    if (_topCoordinate.latitude<=0) {
        _topCoordinate=step.coordinate;
//        NSLog(@"11111  initializeFoureCoordinate_topCoordinate");
    }
    if (_lowCoordinate.latitude<=0) {
        _lowCoordinate=step.coordinate;
//        NSLog(@"2222  initializeFoureCoordinate _lowCoordinate");
    }
    if (_leftCoordinate.longitude<=0) {
        _leftCoordinate=step.coordinate;
//        NSLog(@"3333  initializeFoureCoordinate _leftCoordinate");
    }
    if (_rightCoordinate.longitude<=0) {
        _rightCoordinate=step.coordinate;
//        NSLog(@"44444  initializeFoureCoordinate _rightCoordinate");
    }
}

- (void)computeTotalDistance {
    double distance      = 0;
    double debugDistance = 0;
    NSInteger count = [_steps count];
    NSInteger index =0;
    for (; index<count-1; index++) {
        RunnerStep *firststep  = [_steps objectAtIndex:index];
        RunnerStep *secondstep = [_steps objectAtIndex:index+1];
        MKMapPoint firstPoint  = MKMapPointForCoordinate(firststep.coordinate);
        MKMapPoint secondPoint = MKMapPointForCoordinate(secondstep.coordinate);
        CLLocationDistance foodStep = MKMetersBetweenMapPoints(firstPoint, secondPoint);
        if (foodStep<kRunnerStepValidRangePerSecond) {
            distance +=foodStep;
//        NSLog(@"result of foodStep = %.2f distance = %.2f ",foodStep,distance);
        }
        debugDistance +=firststep.distance;
    }
    RunnerStep *firststep = [_steps firstObject];
    RunnerStep *secondstep= [_steps lastObject];
    _runningTime = secondstep.timestamp - firststep.timestamp;
    _runningDistance = distance;
    _runningSpeed = _runningDistance/_runningTime;
    NSLog(@"************ _totalDistance = %.2f _speed = %.2f interal=%.2f",_runningDistance,_runningSpeed,_runningTime);
    NSLog(@"####### debugDistance = %.2f ",debugDistance);
}

- (MKCoordinateRegion)regionOfCourse {
    double centerLatitue = (_topCoordinate.latitude+_lowCoordinate.latitude)/2;
    double centerLongitue=(_rightCoordinate.longitude+_leftCoordinate.longitude)/2;
//    NSLog(@"centerCoordinateOfCourse _topCoordinate    latitude = %f",_topCoordinate.latitude);
//    NSLog(@"centerCoordinateOfCourse _lowCoordinate    latitude = %f",_lowCoordinate.latitude);
//    NSLog(@"centerCoordinateOfCourse _leftCoordinate   longitude = %f",_leftCoordinate.longitude);
//    NSLog(@"centerCoordinateOfCourse _rightCoordinate  longitude = %f",_rightCoordinate.longitude);
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(centerLatitue, centerLongitue);
    CLLocationDegrees latitudeDelta  = _topCoordinate.latitude-_lowCoordinate.latitude;
    CLLocationDegrees longitudeDelta = _rightCoordinate.longitude-_leftCoordinate.longitude;
    //0.008, 0.008
    MKCoordinateSpan span     = MKCoordinateSpanMake(latitudeDelta*1.5, longitudeDelta*1.2);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    return region;
}
@end
