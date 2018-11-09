//
//  Define.h
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "DeviceAddatper.h"

#define NL_APP_DELEGATE    (AppDelegate *)[UIApplication sharedApplication].delegate

//auto space adapter
#define NL_SPACE_ADDAPTER(space)    [[DeviceAddatper addapter] infinitiveSpace:space]

#define NL_HORIZONTAL_SPACE   [[DeviceAddatper addapter] infinitiveSpace:15.0]


#define NL_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

#define NL_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
/*
 * r g b short
 */
#define NL_RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define NL_BACKGROUND_COLOR  NL_RGBCOLOR(238, 238, 238)
#define NL_THEME_COLOR       NL_RGBCOLOR(251, 101, 60)
