//
//  AppConfig.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#ifndef HACKATHON2015_AppConfig_h
#define HACKATHON2015_AppConfig_h


#define APP_BUILD_INDEX [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define APP_VERSION  [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define DETECT_OS511  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.1)
#define DETECT_OS7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define DETECT_OS8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define LESS_THAN_OS7  ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define LESS_THAN_OS8  ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define TABBAR_HEIGHT 50
#define BannerHeight 180



#endif
