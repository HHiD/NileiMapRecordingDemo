//
//  RunnerCourse.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunnerCourse.h"
#import <MapKit/MKGeometry.h>
#import "CoordinateFilter.h"

@implementation RunnerCourse

- (id)init {
    self             = [super init];
    _steps           = [[NSMutableArray alloc] initWithCapacity:10];
    _runningDistance = 0;
    return self;
}

- (void)addNiewRunnerStep:(RunnerStep*)step {
    RunnerStep *lastStep = [_steps lastObject];
    MKMapPoint firstPoint  = MKMapPointForCoordinate(lastStep.coordinate);
    MKMapPoint secondPoint = MKMapPointForCoordinate(step.coordinate);
    CLLocationDistance foodStep = MKMetersBetweenMapPoints(firstPoint, secondPoint);
    if (foodStep<kRunnerStepValidRangePerSecond) {
        _runningDistance +=foodStep;
        NSLog(@"result of foodStep = %.2f distance = %.2f ",foodStep,_runningDistance);
    }
    [_steps addObject:step];

//    _runningDistance +=step.distance;
}

- (void)computeTotalDistance {
    double distance = 0;
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
        NSLog(@"result of foodStep = %.2f distance = %.2f ",foodStep,distance);
        }

    }
    RunnerStep *firststep = [_steps firstObject];
    RunnerStep *secondstep= [_steps lastObject];
    _runningTime = secondstep.timestamp - firststep.timestamp;
    _runningDistance = distance;
    _runningSpeed = _runningDistance/_runningTime;
    NSLog(@"************ _totalDistance = %.2f _speed = %.2f interal=%.2f",_runningDistance,_runningSpeed,_runningTime);
}

@end
