//
//  AppDelegate.h
//  QBRroQuickStartProject
//
//  Created by Lei Ni on 22/03/2018.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainController.h"
#import "LocationManager.h"
#import "NLDrawerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow           *window;
@property (strong, nonatomic) LocationManager    *locationManager;
@property (strong, nonatomic) NLDrawerController *drawerController;
@property (strong, nonatomic) MainController     *mainController;
@end

