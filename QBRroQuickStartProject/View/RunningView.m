//
//  RunningView.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunningView.h"
#import "NSString+Kit.h"
#import "UIImage+RRKit.h"
#import "Define.h"
#import "Masonry.h"

#define kDistanceTopSpace     NL_SCREEN_HEIGHT/4
#define kDistanceToUnitSpace  NL_SPACE_ADDAPTER(15.0)
#define kDistanceTextSize     110

@implementation RunningView

- (instancetype)initWithFrame:(CGRect)frame {
    //    frame.size.height = kDistanceIconWidth;
    self = [super initWithFrame:frame];
    self.backgroundColor = NL_BACKGROUND_COLOR;
    _pauseStatus = YES;
    [self setupSubviews];
    [self addFinishRunningButton];
    [self addCloseButton];
    return self;
}

- (void)setupSubviews {
    _distanceLabel               = [UILabel new];
    _distanceLabel.textColor     = [UIColor blackColor];
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    _distanceLabel.font          = [UIFont boldSystemFontOfSize:kDistanceTextSize];
    [self addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kDistanceTopSpace);
    }];
    _distanceLabel.text = @"0.00";
    
    UILabel *unitLabel           = [UILabel new];
    unitLabel.textColor         = [UIColor blackColor];
    unitLabel.textAlignment = NSTextAlignmentCenter;
    unitLabel.font          = [UIFont boldSystemFontOfSize:30];
    [self addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_distanceLabel.mas_bottom).offset(kDistanceToUnitSpace);
    }];
    unitLabel.text = @"km";
    
    _timeLabel              = [UILabel new];
    _timeLabel.textColor     = [UIColor blackColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font          = [UIFont boldSystemFontOfSize:21];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(unitLabel.mas_bottom).offset(2*kDistanceToUnitSpace);
    }];
    _timeLabel.text = @"00:00";
    
    
    
    //button setup
    _pauseButton       = [UIButton new];
    UIColor *color    = [UIColor greenColor];
    UIImage *btnImage = [UIImage imageWithColor:color];
    [_pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    _pauseButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    
    [_pauseButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    _pauseButton.layer.cornerRadius = 50;
    _pauseButton.layer.masksToBounds= YES;
    
    [self addSubview:_pauseButton];
    [_pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-kDistanceTopSpace);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [_pauseButton addTarget:self action:@selector(didPauseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addCloseButton {

    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(didCloseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(NL_HORIZONTAL_SPACE);
        make.bottom.equalTo(self.mas_bottom).offset(-NL_HORIZONTAL_SPACE);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

- (void)addFinishRunningButton {
    _finishRunningButton = [UIButton new];
    UIImage *btnImage = [UIImage imageWithColor:NL_THEME_COLOR];
    [_finishRunningButton setTitle:@"finish" forState:UIControlStateNormal];
    _finishRunningButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    
    [_finishRunningButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    _finishRunningButton.layer.cornerRadius = 50;
    _finishRunningButton.layer.masksToBounds= YES;
    [self addSubview:_finishRunningButton];
    [_finishRunningButton addTarget:self action:@selector(didFinishButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_finishRunningButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_pauseButton.mas_bottom).offset(NL_HORIZONTAL_SPACE);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
}

- (void)displayRunningTime:(NSInteger)interval {
    _timeLabel.text = [NSString convertTimeWithTimeInterval:interval];
    
}

#pragma mark - button methods

- (void)didPauseButtonSelected:(id)sender {
    if (_pauseStatus) {
        [_pauseButton setTitle:@"pause" forState:UIControlStateNormal];
        [_delegate pauseButtonSelected:NO];
    }
    else {

        [_pauseButton setTitle:@"resume" forState:UIControlStateNormal];
        [_delegate pauseButtonSelected:YES];
    }
    _pauseStatus = !_pauseStatus;
}

- (void)didFinishButtonSelected:(id)sender {
    [_delegate runnerFinishRunning];
}

- (void)didCloseButtonSelected:(id)sender {
    [_delegate closeButtonSelected];
}
@end
