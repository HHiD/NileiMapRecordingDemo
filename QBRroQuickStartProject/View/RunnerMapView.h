//
//  RunnerMapView.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
/*
 * this class include many map draw method, draw path ,overlay and so on
 */
@interface RunnerMapView : UIView<MKMapViewDelegate,CAAnimationDelegate> {
    MKCircle     *_transparentCircle;
    CAShapeLayer *_shapeLayer;
    MKPolyline   *_polyline;
}
@property(nonatomic,strong) MKMapView *mapView;

@property(nonatomic,strong) NSArray   *runnerSteps;
@property(nonatomic,strong) UILabel   *runningDistanceLabel;
@property(nonatomic,strong) UILabel   *runnerSpeedLabel; 
- (void)showRelocationButton;

@end

