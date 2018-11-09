//
//  RunnerCourse.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunnerStep.h"

@interface RunnerCourse : NSObject

@property(nonatomic,strong) NSMutableArray<RunnerStep*> *steps;
@property(nonatomic,assign) double runningDistance;
@property(nonatomic,assign) double runningSpeed;
@property(nonatomic,assign) NSTimeInterval runningTime;
@property(nonatomic,strong) NSString *date;

- (void)computeTotalDistance;

- (void)addNiewRunnerStep:(RunnerStep*)step;

@end


