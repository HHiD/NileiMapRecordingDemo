//
//  RRCoordCover.h
//  QMapKitSample
//
//  Created by rrkd on 15/8/21.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*
 * The coordinate get by class CLLocationManager is belong to World Geodetic System
 * the MKMapView need Mars Geodetic System coordinate
 */
@interface RRCoordCover : NSObject
//转GCJ-02
+ (CLLocationCoordinate2D)convertWGSToGCJ02:(CLLocationCoordinate2D)wgsLoc;
+ (CLLocationCoordinate2D)convertWGSToGCJ02WithLat:(double)lat lon:(double)lon;
+ (CLLocationCoordinate2D)convertGCJ02ToWGS:(CLLocationCoordinate2D)gcjLoc;
+ (CLLocationCoordinate2D)convertGCJ02ToWGSWithLat:(double)lat lon:(double)lon;
@end
