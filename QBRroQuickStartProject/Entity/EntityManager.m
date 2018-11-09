//
//  EntityManager.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "EntityManager.h"
#import "CoordinateFilter.h"

@implementation EntityManager

+ (NSArray<RunnerStep*>*)cachedRunnerCourses {
 
    return nil;
}


+(RunnerCourse*)readSampleRunnerCourse {
    NSString *areaJson =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"runnerDemoData.js"];
    NSString *str = [NSString stringWithContentsOfFile:areaJson encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData_ = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *sample = [NSJSONSerialization JSONObjectWithData:jsonData_ options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *pinData;
    NSMutableArray *steps = [NSMutableArray arrayWithCapacity:10];
    for (int y=0; y<[sample count]; y++) {
        RunnerStep *step    = [RunnerStep new];
        pinData             = [sample objectAtIndex:y];
        NSString *lng       = pinData[@"lng"];
        NSString *lat       = pinData[@"lat"];
        NSNumber *timestamp = pinData[@"timestamp"];
        step.coordinate     = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
        step.timestamp      = [timestamp doubleValue];
        [steps addObject:step];
    }
    RunnerCourse *runnerCourse = [RunnerCourse new];
    runnerCourse.steps = steps;
    return runnerCourse;
}
+(RunnerCourse*)readRunnerCourse {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:@"leiLocation"];
    
    if (!array) {
        return nil;
    }
    NSDictionary *pinData;
    NSMutableArray *steps = [NSMutableArray arrayWithCapacity:10];
    for (int y=0; y<[array count]; y++) {
        RunnerStep *step    = [RunnerStep new];
        pinData             = [array objectAtIndex:y];
        NSString *lng       = pinData[@"lng"];
        NSString *lat       = pinData[@"lat"];
        NSNumber *timestamp = pinData[@"timestamp"];
        step.coordinate     = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
        step.timestamp      = [timestamp doubleValue];
        [steps addObject:step];
    }
    if ([steps count]>0) {
        RunnerCourse *course = [RunnerCourse new];
        course.steps = [CoordinateFilter processCoordinateWithArray:steps];
        return course;
    }
    else {
        return nil;
    }
    
}

//@"lng"      :lng,
//@"lat"      :lat,
//@"timestamp":timestamp,
//@"course"   :derection,
//@"speed"    :speedNumbber,
//@"distance" :distance
@end
