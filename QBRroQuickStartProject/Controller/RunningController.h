//
//  RunningController.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  Discussion:
 *    runner start to running dashboard , in this dashboard runner can stop and resume running.
 */

@interface RunningController : UIViewController

@property(nonatomic,strong) NSTimer  *runningTimer;
@property(nonatomic,assign) int interval;
@end


