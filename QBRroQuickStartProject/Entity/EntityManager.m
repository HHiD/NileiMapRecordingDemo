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
//    return [EntityManager readRunnerCourse];

    NSString *areaJson =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"runnerDemoData.js"];
    NSString *str = [NSString stringWithContentsOfFile:areaJson encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData_ = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *sample = [NSJSONSerialization JSONObjectWithData:jsonData_ options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *pinData;
    RunnerCourse *runnerCourse = [RunnerCourse new];

    for (int y=0; y<[sample count]; y++) {
        RunnerStep *step    = [RunnerStep new];
        pinData             = [sample objectAtIndex:y];
        NSString *lng       = pinData[@"lng"];
        NSString *lat       = pinData[@"lat"];
        NSNumber *timestamp = pinData[@"timestamp"];
        step.coordinate     = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
        step.timestamp      = [timestamp doubleValue];
        [runnerCourse addNiewRunnerStep:step];
    }
    return runnerCourse;
}

+(RunnerCourse*)readRunnerCourse {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:@"kocation"];
    
    if (!array) {
        return nil;
    }
    NSDictionary *pinData;
    RunnerCourse *course = [RunnerCourse new];
    for (int y=0; y<[array count]; y++) {
        RunnerStep *step    = [RunnerStep new];
        pinData             = [array objectAtIndex:y];
        NSString *lng       = pinData[@"lng"];
        NSString *lat       = pinData[@"lat"];
        NSNumber *timestamp = pinData[@"timestamp"];
        NSNumber *speed     = pinData[@"speed"];
        NSNumber *distance  = pinData[@"distance"];
        step.coordinate     = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
        step.timestamp      = [timestamp doubleValue];
        step.distance       = [distance doubleValue];
        step.speed          = [speed doubleValue];
        [course addNiewRunnerStep:step];
    }
//    course.steps = [CoordinateFilter processCoordinateWithArray:steps];
    return course;
    
}

+ (void)testMethodTemporarySaveRunnerStep:(RunnerCourse*)course{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *cache = [defaults valueForKey:@"kocation"];
    if (!cache) {
        cache = [NSArray new];
    }
    NSMutableArray *mutable = [NSMutableArray arrayWithArray:cache];
    for (RunnerStep *step in course.steps) {
        [mutable addObject:[step getDictionary]];
        [defaults setValue:mutable forKey:@"kocation"];
    }
    [defaults synchronize];
}

//@"lng"      :lng,
//@"lat"      :lat,
//@"timestamp":timestamp,
//@"course"   :derection,
//@"speed"    :speedNumbber,
//@"distance" :distance
@end
