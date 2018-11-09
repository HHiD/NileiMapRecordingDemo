//
//  RRMapGeometry.h
//  QMapKitSample
//
//  Created by rrkd on 15/8/19.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#ifndef __QMapKit__RRMapGeometry__
#define __QMapKit__RRMapGeometry__



#ifdef __cplusplus
extern "C" {
#endif
    
    /*!
     *  @brief  定义了以CLLocationDegree为单位的矩形, 一单位纬度(latitudeDelta)大约为111公里; 单位经度和纬度相关,一单位经度值(latitudeDelta)赤道时大约是111公里, 到极地为0
     */
    typedef struct {
        CLLocationDegrees latitudeDelta;
        CLLocationDegrees longitudeDelta;
    } RRCoordinateSpan;
    
    /*!
     * 定义了地图的某一部份的数据结构
     */
    typedef struct {
        CLLocationCoordinate2D center;
        RRCoordinateSpan span;
    } RRCoordinateRegion;
    
    /*!
     *  @brief  构造QCoordinateSpan类型数据
     *
     *  @param latitudeDelta  纬度值
     *  @param longitudeDelta 经度值
     *
     *  @return 构造的span数据
     */
    static inline RRCoordinateSpan RRCoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
    {
        return (RRCoordinateSpan){latitudeDelta, longitudeDelta};
    }
    
    /*!
     *  @brief  构造QCoordinateRegion类型数据
     *
     *  @param centerCoordinate 中心点经纬度坐标
     *  @param span             span大小
     *
     *  @return 构造的region数据
     */
    static inline RRCoordinateRegion RRCoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, RRCoordinateSpan span)
    {
        return (RRCoordinateRegion){centerCoordinate, span};
    }
    
#ifdef __cplusplus
}
#endif

#endif /* defined(__QMapKit__RRMapGeometry__) */
