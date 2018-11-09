//
//  RunnerBroadcast.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVSpeechSynthesis.h>

@protocol RunnerBroadcastDelegate <NSObject>

- (void)didFinishRunnerBroadcast;

@end

/*
 * to broadcast and notice runner per 1km
 */
@interface RunnerBroadcast : NSObject<AVSpeechSynthesizerDelegate>

@property(nonatomic,strong) AVSpeechSynthesizer         *speaker;
@property(nonatomic,assign) id<RunnerBroadcastDelegate> delegate;

- (void)broadcastWithString:(NSString*)txt;

@end

