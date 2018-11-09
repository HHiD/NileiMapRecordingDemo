//
//  RunnerStep.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunnerStep.h"

@implementation RunnerStep
- (id)initRunnerStepWith:(CLLocation*)location {
    self        = [super init];
    _speed      = location.speed;
    _timestamp  = location.timestamp.timeIntervalSince1970;
    _course     = location.course;
    _coordinate = location.coordinate;
    return self;
}

- (NSDictionary*)getDictionary {
    NSString *lng          = [NSString stringWithFormat:@"%f",_coordinate.longitude];
    NSString *lat          = [NSString stringWithFormat:@"%f",_coordinate.latitude];
    NSNumber *timestamp    = [NSNumber numberWithDouble:_timestamp];
    NSNumber *derection    = [NSNumber numberWithDouble:_course];
    NSNumber *speedNumbber = [NSNumber numberWithDouble:_speed];
    NSNumber *distance     = [NSNumber numberWithDouble:_distance];
    NSDictionary *item = @{
                           @"lng"      :lng,
                           @"lat"      :lat,
                           @"timestamp":timestamp,
                           @"course"   :derection,
                           @"speed"    :speedNumbber,
                           @"distance" :distance
                           };
    return item;
}
@end
