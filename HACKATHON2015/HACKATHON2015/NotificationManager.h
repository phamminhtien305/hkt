//
//  NotificationManager.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/29/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * UpdatedUserInfo = @"updated user info";

@interface NotificationManager : NSObject

+(void)postNotificationWhenUpdatedUserInfoWithObject:(id)object;

+(void)registerNotificationWhenUpdatedUserInfoWithOnserver:(id)server withSelector:(SEL)selector;

@end
