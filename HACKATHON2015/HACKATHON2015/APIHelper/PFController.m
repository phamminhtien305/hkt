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

+ (NSString*) stringFromState:(REPORT_STATE) state {
    switch (state) {
        case open_:
            return @"open";
            break;
        case pending:
            return @"pending";
            break;
        case private_:
            return @"private";
            break;
        case close_:
            return @"close";
            break;
        case unpublish:
            return @"unpublish";
        default:
            break;
    }
    return @"open";
}

+ (NSDictionary*) pfObjectToDict:(PFObject*) object {
    NSArray * allKeys = [object allKeys];
    NSMutableDictionary * retDict = [[NSMutableDictionary alloc] init];
    for (NSString *key in allKeys) {
        [retDict setObject:[object objectForKey:key] forKey:key];
    }
    [retDict setObject:object.objectId forKeyedSubscript:@"objectId"];
//    [retDict setObject:object.createdAt forKey:@"createdAt"];
//    [retDict setObject:object.updatedAt forKey:@"updateAt"];
    return  retDict;
}
@end
