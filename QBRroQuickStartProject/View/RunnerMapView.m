//
//  RunnerMapView.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "RunnerMapView.h"
#import "UIImage+RRKit.h"
#import "Masonry.h"
#import "Define.h"


#define kAnimationDuration 6
#define kMapMaskColor      [UIColor colorWithRed:0 green:0 blue:0 alpha:.6]
#define kDashboardHeight  NL_SCREEN_HEIGHT/4

@implementation RunnerMapView {
    UIView  *_dashBoardView;
    UILabel *_runningTime;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = NL_BACKGROUND_COLOR;
    [self setupViews];
    return self;
}


- (void)setupViews {
    _mapView                   = [MKMapView new];
    _mapView.delegate          = self;
    _mapView.zoomEnabled       = NO;
    _mapView.scrollEnabled     = NO;
    _mapView.pitchEnabled      = NO;
    _mapView.rotateEnabled     = NO;
    [self addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-kDashboardHeight);
    }];
    
    _dashBoardView = [UIView new];
    _dashBoardView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_dashBoardView];
    [_dashBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(kDashboardHeight);
    }];
    
    _runningDistanceLabel               = [UILabel new];
    _runningDistanceLabel.textColor     = [UIColor blackColor];
    _runningDistanceLabel.font          = [UIFont boldSystemFontOfSize:50.0];
    [_dashBoardView addSubview:_runningDistanceLabel];
    [_runningDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_dashBoardView).offset(NL_HORIZONTAL_SPACE);
    }];
    _runningDistanceLabel.text = @"0km";
    
    _runnerSpeedLabel               = [UILabel new];
    _runnerSpeedLabel.textColor     = [UIColor blackColor];
    _runnerSpeedLabel.font          = [UIFont boldSystemFontOfSize:40.0];
    [_dashBoardView addSubview:_runnerSpeedLabel];
    [_runnerSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dashBoardView).offset(NL_HORIZONTAL_SPACE);
        make.centerY.equalTo(_dashBoardView);
    }];
    _runnerSpeedLabel.text = @"s";
}

- (void)showRelocationButton {
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




#pragma mark - public mathods

- (void)setRunnerCourse:(RunnerCourse *)runnerCourse {
    _runnerCourse = runnerCourse;
    MKCoordinateRegion region = [_runnerCourse regionOfCourse];
    [self addTransparentOverlay:region.center];
    [self moveMapWithRegion:region];
    [self addHeaderAnnotation];
    [self performSelector:@selector(startRunnerPathAnimation) withObject:self afterDelay:1.0];
}

- (void)moveMapWithRegion:(MKCoordinateRegion)region {
//    [_mapView setRegion:region animated:NO];
//    CGPoint point    = [_mapView convertCoordinate:region.center toPointToView:_mapView];
//    CGFloat y        = (NL_SCREEN_HEIGHT+kDashboardHeight)/2;
//    CGFloat x        = NL_SCREEN_WIDTH/2;
//    CGPoint newpoint = CGPointMake(x, y);
//    CLLocationCoordinate2D coor = [_mapView convertPoint:newpoint toCoordinateFromView:_mapView];
//    region.center    = coor;
    [_mapView setRegion:region animated:NO];
}

- (void)resetLocation:(id)sender {
//    MKCoordinateSpan span     = MKCoordinateSpanMake(0.008, 0.008);
//    MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
//    [_mapView setRegion:region animated:NO];
}

- (void)drawRunnerPathWithSteps {
//    NSArray *array = [LocationManager debugprintCasheLocation];
    int sizeOfCoord = (int)_runnerCourse.steps.count;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D)*sizeOfCoord);
    int index = 0;
    for (RunnerStep *step in _runnerCourse.steps) {
        coords[index] = step.coordinate;
        index ++;
    }
    _polyline = [MKPolyline polylineWithCoordinates:coords count:_runnerCourse.steps.count];
    [_mapView addOverlay:_polyline];
    reallocf(coords, sizeof(CLLocationCoordinate2D)*sizeOfCoord);
}

#pragma mark - layer animation

- (void)addHeaderAnnotation {
    _headerPoint      = [MKPointAnnotation new];
    RunnerStep *start = [_runnerCourse.steps firstObject];
    _headerPoint.coordinate = start.coordinate;
    [_mapView addAnnotation:_headerPoint];
}


- (CAAnimation *)constructAnnotationAnimationWithPath:(CGPathRef)path{
    if (path == NULL){
        return nil;
    }
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.duration = kAnimationDuration;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrameAnimation.path = path;
    keyFrameAnimation.calculationMode = kCAAnimationPaced;
    return keyFrameAnimation;
}


- (void)addTransparentOverlay:(CLLocationCoordinate2D)coord {
    _transparentCircle = [MKCircle circleWithCenterCoordinate:coord radius:1000000];
    [_mapView addOverlay:_transparentCircle level:1];
}

- (void)startRunnerPathAnimation {
     int sizeOfCoord = (int)_runnerCourse.steps.count;
     CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D)*sizeOfCoord);
     int index = 0;
     for (RunnerStep *step in _runnerCourse.steps) {
     coords[index] = step.coordinate;
     index ++;
     }
     
     CGPoint *points = [self pointsForCoordinates:coords count:sizeOfCoord];
     CGPathRef path  = [self pathForPoints:points count:sizeOfCoord];
     [self initShapeLayerWithPath:path];
     CAAnimation *shapeLayerAnimation = [self constructShapeLayerAnimation];
     shapeLayerAnimation.delegate = self;
     shapeLayerAnimation.removedOnCompletion = NO;
     shapeLayerAnimation.fillMode = kCAFillModeForwards;
     [_shapeLayer addAnimation:shapeLayerAnimation forKey:@"shape"];
    
    MKAnnotationView *headerView = [self.mapView viewForAnnotation:_headerPoint];
    CAAnimation *headerAnimation = [self constructAnnotationAnimationWithPath:path];
    headerAnimation.delegate     = self;
    [headerView.layer addAnimation:headerAnimation forKey:@"annotation"];
    
     reallocf(coords, sizeof(CLLocationCoordinate2D)*sizeOfCoord);
}

- (void)initShapeLayerWithPath:(CGPathRef)path{
    if (_shapeLayer) {
        [_shapeLayer removeFromSuperlayer];
    }
    else {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.lineJoin    = kCALineCapRound;
        _shapeLayer.lineWidth   = 5.0;
    }
    _shapeLayer.path = path;
    [_mapView.layer addSublayer:_shapeLayer];
}



- (CAAnimation *)constructShapeLayerAnimation{
    CABasicAnimation *theStrokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    theStrokeAnimation.duration  = kAnimationDuration;
    theStrokeAnimation.fromValue = @0.f;
    theStrokeAnimation.toValue   = @1.f;
    theStrokeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return theStrokeAnimation;
}


- (CGPoint *)pointsForCoordinates:(CLLocationCoordinate2D *)coordinates count:(NSUInteger)count {
    if (coordinates == NULL || count <= 1) {
        return NULL;
    }
    /* 申请屏幕坐标存储空间. */
    CGPoint *points = (CGPoint *)malloc(count * sizeof(CGPoint));
    /* 经纬度转换为屏幕坐标. */
    for (int i = 0; i < count; i++) {
        points[i] = [_mapView convertCoordinate:coordinates[i] toPointToView:_mapView];
        NSLog(@"points %d x=%.2f,y=%.2f",i,points[i].x,points[i].y);
    }
    return points;
}

- (CGMutablePathRef)pathForPoints:(CGPoint *)points count:(NSUInteger)count {
    if (points == NULL || count <= 1){
        return NULL;
    }
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddLines(path, NULL, points, count);
    return path;
}
- (void)removePloyline {
    if (_polyline) {
        [_mapView removeOverlay:_polyline];
    }
}

#pragma mark - MKMapViewDelegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKOverlayRenderer *render=nil;
        MKPolylineRenderer *polyLine=[[MKPolylineRenderer alloc] initWithOverlay:(MKPolyline*)overlay] ;
        [polyLine setStrokeColor:[UIColor orangeColor]];
        polyLine.lineWidth=5.0;
        render = polyLine;
        return render;
    }
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonRenderer*    aRenderer = [[MKPolygonRenderer alloc] initWithPolygon:(MKPolygon*)overlay];
        
        aRenderer.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        aRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        aRenderer.lineWidth = 3;
        
        return aRenderer;
    }
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        //半透明蒙层
        MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.fillColor = kMapMaskColor;
        return circleRenderer;
    }
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    // 位置发生变化调用
    //    NSLog(@"lan = %f, long = %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//    [self resetLocation:nil];
//     [self startRunnerPathAnimation];
}
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (annotation==_headerPoint) {
        MKAnnotationView *annotation = [[MKAnnotationView alloc] initWithAnnotation:_headerPoint reuseIdentifier:@"reuseannotaion"];
        annotation.image = [UIImage imageNamed:@"icon_header"];
        annotation.hidden = YES;
        return annotation;
    }
    else {
        return nil;
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    MKAnnotationView *headerView = [self.mapView viewForAnnotation:_headerPoint];
    headerView.hidden = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self drawRunnerPathWithSteps];
        NSLog(@"%s",__FUNCTION__);
        MKAnnotationView *headerView = [self.mapView viewForAnnotation:_headerPoint];
        headerView.hidden = YES;
    }
};

@end
