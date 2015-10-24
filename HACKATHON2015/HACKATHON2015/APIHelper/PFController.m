//
//  PFController.m
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "PFController.h"
#import "DeviceHelper.h"
#import <Parse/Parse.h>

@implementation PFController

+ (void) registerPFUser{
    PFUser *user = [PFUser currentUser];
    if (!user) {
        PFUser *user = [PFUser user];
        [user setValue:@"user" forKey:@"group"];
        user.username = [DeviceHelper getDeviceID];
        user.password = [DeviceHelper getDeviceID];
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error.code == kPFErrorUsernameTaken) {
                [PFUser logInWithUsername:[DeviceHelper getDeviceID] password:[DeviceHelper getDeviceID]];
            }
        }];
    }
}

+ (BOOL) isAdmin {
    PFUser *user = [PFUser currentUser];
    if (user) {
        return [user[@"group"] isEqualToString:@"admin"];
    }
    return NO;
}

+ (BOOL) isAnonymous {
    PFUser *user = [PFUser currentUser];
    if (user) {
        return !user[@"user_full_name"] || [user[@"user_fullname"] isEqualToString:@""];
    }
    return YES;
}

+ (NSString*) textStringFromState:(REPORT_STATE) state {
    switch (state) {
        case open_:
            return @"Đang xử lý";
            break;
        case pending:
            return @"Chờ duyệt";
            break;
        case private_:
            return @"Gửi admin";
            break;
        case close_:
            return @"Đã xử lý";
            break;
        case unpublish:
            return @"Đã đóng";
        default:
            break;
    }
    return @"Đang xử lý";
}

@end
