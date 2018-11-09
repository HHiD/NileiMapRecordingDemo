//
//  RunningView.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RunningViewDelegate <NSObject>

@optional
- (void)pauseButtonSelected:(BOOL)paused;

- (void)closeButtonSelected;

- (void)runnerFinishRunning;

@end

@interface RunningView : UIView {
    UILabel  *_distanceLabel;
    UILabel  *_timeLabel;
    UIButton *_pauseButton;
    BOOL      _pauseStatus;
    UIButton *_finishRunningButton;
}

@property(nonatomic,assign) id<RunningViewDelegate> delegate;

- (void)displayRunningTime:(NSInteger)interval;

@end

