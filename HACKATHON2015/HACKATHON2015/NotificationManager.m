
//
//  NotificationManager.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/29/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

#pragma mark - Updated user info
+(void)postNotificationWhenUpdatedUserInfoWithObject:(id)object{
    [[NSNotificationCenter defaultCenter] postNotificationName:UpdatedUserInfo object:object userInfo:nil];
}


+(void)registerNotificationWhenUpdatedUserInfoWithOnserver:(id)server withSelector:(SEL)selector{
    [[NSNotificationCenter defaultCenter] addObserver:server selector:selector name:UpdatedUserInfo object:nil];
}
@end
