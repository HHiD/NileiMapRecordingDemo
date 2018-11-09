//
//  MainView.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "MainView.h"
#import "LocationManager.h"
#import "EntityManager.h"
#import "UIImage+RRKit.h"
#import "Masonry.h"
#import "Define.h"

#define kAnimationDuration 6
#define kMapMaskColor      [UIColor colorWithRed:256 green:256 blue:256 alpha:.15]
@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
    //    frame.size.height = kDistanceIconWidth;
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    [self setupViews];
    [self addUserCenterButton];
    [self addStartRunningButton];
     [self addTransparentOverlay];
    return self;
}


#pragma private mathod

- (void)setupViews {
    _mapView                   = [MKMapView new];
    _mapView.delegate          = self;
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled       = NO;
    _mapView.scrollEnabled     = NO;
    _mapView.pitchEnabled      = NO;
    _mapView.rotateEnabled     = NO;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    [self addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 定位按钮
    UIButton *resetLocationBtn = [UIButton new];
    [resetLocationBtn setImage:[UIImage imageNamed:@"nl_relocation"] forState:UIControlStateNormal];
    
    [self addSubview:resetLocationBtn];
    [resetLocationBtn addTarget:self action:@selector(resetLocation:) forControlEvents:UIControlEventTouchUpInside];
    [resetLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
}

- (void)addStartRunningButton {
    UIButton *runBtn  = [UIButton new];
    UIColor *color    = [UIColor colorWithRed:251/255.0f green:101/255.0f blue:60/255.0f alpha:0.8];
    UIImage *image    = [UIImage imageWithColor:color];
    [runBtn setTitle:@"start" forState:UIControlStateNormal];
    runBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    [runBtn setBackgroundImage:image forState:UIControlStateNormal];
    runBtn.layer.cornerRadius = 50;
    runBtn.layer.masksToBounds= YES;
    
    [self addSubview:runBtn];
    [runBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self).offset(-25);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [runBtn addTarget:self action:@selector(startRunningButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)startRunningButtonTouched:(id)sender {
    [_delegate didStartRunningTouched];
}


- (void)addUserCenterButton {
    UIButton *userBtn  = [UIButton new];
    UIImage *image     = [UIImage imageNamed:@"runner_icon.JPG"];
    [userBtn setBackgroundImage:image forState:UIControlStateNormal];
    userBtn.layer.cornerRadius = 28;
    userBtn.layer.masksToBounds= YES;
    
    [self addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(self).offset(-25);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    [userBtn addTarget:self action:@selector(userButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)userButtonTouched:(id)sender {
    [_delegate didUserCenterTouched];
}

- (void)addTransparentOverlay{
    _transparentCircle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.905, 116.398) radius:100000000];
    [_mapView addOverlay:_transparentCircle level:1];
}




- (void)resetLocation:(id)sender {
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
    CLLocationCoordinate2D coord = _mapView.userLocation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.008, 0.008);
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
    [_mapView setRegion:region animated:YES];
}




#pragma mark - runer path animation


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    // 位置发生变化调用
//    NSLog(@"lan = %f, long = %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    [self resetLocation:nil];
}



@end
