//
//  MainView.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MainViewDelegate <NSObject>

- (void)didUserCenterTouched;

- (void)didStartRunningTouched;

@end


@interface MainView : UIView<MKMapViewDelegate> {
    MKCircle     *_transparentCircle;
}
@property(nonatomic,strong) MKMapView *mapView;
@property(nonatomic,assign) id<MainViewDelegate> delegate;
@end

