//
//  RunnerBroadcast.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunnerBroadcast.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation RunnerBroadcast

- (id)init {
    self              = [super init];
    _speaker          = [[AVSpeechSynthesizer alloc] init];
    _speaker.delegate = self;
    return self;
}

- (void)broadcastWithString:(NSString*)txt {
    AVSpeechUtterance *speech = [[AVSpeechUtterance alloc]initWithString:txt];
    speech.pitchMultiplier    = 1.2;
    speech.volume             = 1;
    AVSpeechSynthesisVoice *lg= [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//en-US
    speech.voice              = lg;
    speech.rate               = 0.5;
    [_speaker speakUtterance:speech];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    [_delegate didFinishRunnerBroadcast];
}
@end
