//
//  RunnerStep.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunnerStep : NSObject
@property(nonatomic,assign) double distance;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,assign) CLLocationSpeed        speed;
@property(nonatomic,assign) NSTimeInterval         timestamp;
/*
 *  course
 *
 *  Discussion:
 *    Returns the course of the location in degrees true North. Negative if course is invalid.
 *
 *  Range:
 *    0.0 - 359.9 degrees, 0 being true North
 */
@property(assign, nonatomic) CLLocationDirection course;

- (id)initRunnerStepWith:(CLLocation*)location;

- (NSDictionary*)getDictionary;

@end

NS_ASSUME_NONNULL_END
