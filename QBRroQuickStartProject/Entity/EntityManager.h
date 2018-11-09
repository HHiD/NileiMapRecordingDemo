//
//  EntityManager.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunnerCourse.h"


@interface EntityManager : NSObject

+ (NSArray<RunnerStep*>*)cachedRunnerCourses;

+(RunnerCourse*)readRunnerCourse;

//demo method
+(RunnerCourse*)readSampleRunnerCourse;
@end


