//
//  RRCoordCover.m
//  QMapKitSample
//
//  Created by rrkd on 15/8/21.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "RRCoordCover.h"
#import "RRMapGeometry.h"

@implementation RRCoordCover






/**
 * Gps84 to  (GCJ-02): World Geodetic System ==> Mars Geodetic System
 *
 */
+ (CLLocationCoordinate2D)convertWGSToGCJ02WithLat:(double)lat lon:(double)lon
{
    RRCoordinateSpan span = [self delta:lat with:lon];

    double mgLat = lat + span.latitudeDelta;
    double mgLon = lon + span.longitudeDelta;
    return CLLocationCoordinate2DMake(mgLat, mgLon);
}

+ (CLLocationCoordinate2D)convertWGSToGCJ02:(CLLocationCoordinate2D)wgsLoc
{
    return [self convertWGSToGCJ02WithLat:wgsLoc.latitude lon:wgsLoc.longitude];
}

//
/**
 * * Mars Geodetic System (GCJ-02) to Gps84
 * */
+ (CLLocationCoordinate2D)convertGCJ02ToWGSWithLat:(double)lat lon:(double)lon
{
    RRCoordinateSpan span = [self delta:lat with:lon];

    double mgLat = lat + span.latitudeDelta;
    double mgLon = lon + span.longitudeDelta;

    double latitude  = lat * 2 - mgLat;
    double lontitude = lon * 2 - mgLon;
    return CLLocationCoordinate2DMake(latitude, lontitude);
}

+ (CLLocationCoordinate2D)convertGCJ02ToWGS:(CLLocationCoordinate2D)gcjLoc{
    
    return [self convertGCJ02ToWGSWithLat:gcjLoc.latitude lon:gcjLoc.longitude];
}



#pragma mark -  Helper Methods

const double a  = 6378245.0;
const double ee = 0.00669342162296594323;
const double pi = M_PI;

+ (RRCoordinateSpan)delta:(double)lat with:(double)lon
{
    double dLat   = [self transformLat:lon - 105.0 y:lat - 35.0];
    double dLon   = [self transformLon:lon - 105.0 y:lat - 35.0];
    double radLat = lat / 180.0 * pi;
    double magic  = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);

    return RRCoordinateSpanMake(dLat, dLon);
}


+ (double)transformLat:(double)x y:(double)y
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y
                 + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
}


+ (double)transformLon:(double)x y:(double)y
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1
                 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0
                                                     * pi)) * 2.0 / 3.0;
    return ret;
}


@end
