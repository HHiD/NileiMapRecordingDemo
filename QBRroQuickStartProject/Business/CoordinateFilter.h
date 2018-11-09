//
//  CoordinateFilter.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunnerStep.h"

//the maximum distance that a runner can reach per second , assume 10 meter per second
#define kRunnerStepValidRangePerSecond 10.0

/**
 *  Discussion
 *  to filte error coordination ,mainly discard range deviation coordination 
 */
@interface CoordinateFilter : NSObject

/**
 *  to filte error coordination ,mainly discard range deviation coordination
 */
+ (NSArray*)processCoordinateWithArray:(NSArray<RunnerStep*>*) steps;

@end

