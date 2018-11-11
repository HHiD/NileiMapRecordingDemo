//
//  RunnerMapView.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EntityManager.h"

/*
 * this class include many map draw method, draw path ,overlay and so on
 */
@interface RunnerMapView : UIView<MKMapViewDelegate,CAAnimationDelegate> {
    MKCircle          *_transparentCircle;
    CAShapeLayer      *_shapeLayer;
    MKPolyline        *_polyline;
    MKPointAnnotation *_headerPoint;
}
@property(nonatomic,strong) MKMapView *mapView;

@property(nonatomic,strong) RunnerCourse  *runnerCourse;
@property(nonatomic,strong) UILabel       *runningDistanceLabel;
@property(nonatomic,strong) UILabel       *runnerSpeedLabel;
- (void)showRelocationButton;

@end

