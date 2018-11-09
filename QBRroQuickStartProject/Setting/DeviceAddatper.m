//
//  DeviceAddatper.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "DeviceAddatper.h"



#define kNormalLargeRate 1.2

#define kFontRate        1.0



@implementation DeviceAddatper {
    RRDeviceType _deviceType;
}

+ (instancetype)addapter {
    static DeviceAddatper *applicationAddapter = nil;
    static dispatch_once_t       once_t;
    dispatch_once(&once_t, ^{
        applicationAddapter = [[DeviceAddatper alloc] init];
    });
    return applicationAddapter;
}

-(id)init {
    self=[super init];
    if (self) {
        _deviceType = [DeviceAddatper currentDeviceType];
        
    }
    return self;
}

+ (RRDeviceType)currentDeviceType {
    RRDeviceType type;
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    if (deviceWidth<330.0) {
        type = RRDeviceCompact;
    }
    else if (deviceWidth>330.0&&deviceWidth<385) {
        type = RRDeviceNormal;
    }
    else {
        type = RRDeviceLarge;
    }
    return type;
}


#pragma mark - 不定式配置公式

- (CGFloat)infinitiveSpace:(CGFloat)space {
    if (_deviceType==RRDeviceLarge) {
        return space*kNormalLargeRate;
    }
    else {
        return space;
    }
}

- (UIFont *)infinitiveBoldFont:(CGFloat )size {
    if (_deviceType==RRDeviceLarge) {
        return [UIFont boldSystemFontOfSize:(size+kFontRate)];
    }
    else if (_deviceType==RRDeviceNormal) {
        return [UIFont boldSystemFontOfSize:size];
    }
    else {
        return [UIFont boldSystemFontOfSize:size-1.0];
    }
}

- (UIFont *)infinitiveFont:(CGFloat )size {
    if (_deviceType==RRDeviceLarge) {
        return [UIFont systemFontOfSize:(size+kFontRate)];
    }
    else if (_deviceType==RRDeviceNormal) {
        return [UIFont systemFontOfSize:size];
    }
    else {
        return [UIFont systemFontOfSize:size-1.0];
    }
}

@end
