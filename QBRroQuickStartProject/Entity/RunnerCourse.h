//
//  RunnerCourse.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKGeometry.h>
#import "RunnerStep.h"

@interface RunnerCourse : NSObject

@property(nonatomic,strong) NSMutableArray<RunnerStep*> *steps;
@property(nonatomic,assign) double runningDistance;
@property(nonatomic,assign) double runningSpeed;
@property(nonatomic,assign) NSTimeInterval runningTime;
@property(nonatomic,strong) NSString *date;

//topest latitude of Coordinate
@property(nonatomic,assign) CLLocationCoordinate2D topCoordinate;
//rightest latitude of Coordinate
@property(nonatomic,assign) CLLocationCoordinate2D rightCoordinate;
//leftest latitude of Coordinate
@property(nonatomic,assign) CLLocationCoordinate2D leftCoordinate;
//lowest latitude of Coordinate
@property(nonatomic,assign) CLLocationCoordinate2D lowCoordinate;

- (void)computeTotalDistance;

- (void)addNiewRunnerStep:(RunnerStep*)step;

- (MKCoordinateRegion)regionOfCourse;

@end


