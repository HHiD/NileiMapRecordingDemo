//
//  CoordinateFilter.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "CoordinateFilter.h"
#import <MapKit/MKGeometry.h>
@implementation CoordinateFilter

+ (NSMutableArray*)processCoordinateWithArray:(NSArray<RunnerStep*>*) steps {
    NSMutableArray *newSteps = [NSMutableArray arrayWithCapacity:10];
    NSInteger count = [steps count];
    NSInteger index = 1;
    for (; index<count-2; index++) {
        RunnerStep *first = [steps objectAtIndex:index-1];
        RunnerStep *second = [steps objectAtIndex:index];
        RunnerStep *third = [steps objectAtIndex:index+1];
        CLLocationDistance firstToSecond = [CoordinateFilter metersBetweenMapPoints:first with:second];
        CLLocationDistance secondToThird = [CoordinateFilter metersBetweenMapPoints:second with:third];
        CLLocationDistance firstToThird  = [CoordinateFilter metersBetweenMapPoints:first with:third];
        if (firstToSecond<kRunnerStepValidRangePerSecond&&secondToThird<kRunnerStepValidRangePerSecond&&firstToThird<kRunnerStepValidRangePerSecond) {
            [newSteps addObject:second];
//            NSLog(@"添加正常点 速度 firstToSecond = %.2f secondToThird = %.2f ",firstToSecond,secondToThird);
        }
        else {
//            NSLog(@"异常的抛弃 异常速度 firstToSecond = %.2f secondToThird = %.2f firstToThird = %.2f",firstToSecond,secondToThird,firstToThird);
            
        }
    }
    
    return newSteps;
}

+(CLLocationDistance)metersBetweenMapPoints:(RunnerStep*)first with:(RunnerStep*)second {
    MKMapPoint newPoint = MKMapPointForCoordinate(first.coordinate);
    MKMapPoint oldPoint = MKMapPointForCoordinate(second.coordinate);
    CLLocationDistance distance = MKMetersBetweenMapPoints(newPoint, oldPoint);
//    NSLog(@"oldPoint.distance=%.2f,newPoint.distance=%.2f,distance=%.2f",first.distance,second.distance,distance);
//    NSTimeInterval interval = second.timestamp-first.timestamp;
//    CLLocationSpeed speed = distance/interval;
//    NSLog(@"distance=%.2f,interval=%.2f,speed=%.2f",distance,interval,speed);
//    NSLog(@"first.speed=%.2f,second.speed=%.2f",first.speed,second.speed);
    return distance;
}
@end
