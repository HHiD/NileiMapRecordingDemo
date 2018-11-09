//
//  AppDelegate+init.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "AppDelegate+init.h"

@implementation AppDelegate (init)

- (void)initControllers {
    self.mainController   = [MainController new];
    self.drawerController = [[NLDrawerController alloc] initWithRootViewController:self.mainController];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
}

- (void)initBusiness {
    self.locationManager = [LocationManager new];
    [self.locationManager startLocationManager];
}

@end
