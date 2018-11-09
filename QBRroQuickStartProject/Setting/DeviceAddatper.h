//
//  DeviceAddatper.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/*
 * 将iphone设备分为三个大小等级
 */
typedef enum {
    RRDeviceCompact = 1,
    RRDeviceNormal  = 2,
    RRDeviceLarge   = 3
} RRDeviceType;

/*
 * auto space adapter for different size of iphone 
 */
@interface DeviceAddatper : NSObject


+ (instancetype)addapter;

+ (RRDeviceType)currentDeviceType;

//不定式配置公式 字体大小
- (UIFont *)infinitiveFont:(CGFloat )size;

- (UIFont *)infinitiveBoldFont:(CGFloat )size;

//不定式配置公式 距离大小
- (CGFloat)infinitiveSpace:(CGFloat)space;
@end
