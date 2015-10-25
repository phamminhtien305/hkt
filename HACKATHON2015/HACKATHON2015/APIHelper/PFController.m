//
//  PFController.m
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "PFController.h"
#import "DeviceHelper.h"
#import "BaseObject.h"
#import <Parse/Parse.h>

@implementation PFController

+ (void) registerPFUserWithCompletionBlock:(AppBOOLBlock) completeBlock{
    PFUser *user = [PFUser currentUser];
    if (!user) {
        PFUser *user = [PFUser user];
        [user setValue:@"user" forKey:@"group"];
        [user setValue:[[UIDevice currentDevice] systemName] forKey:@"device_name"];
        user.username = [DeviceHelper getDeviceID];
        user.password = [DeviceHelper getDeviceID];
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error.code == kPFErrorUsernameTaken) {
                [PFUser logInWithUsername:[DeviceHelper getDeviceID] password:[DeviceHelper getDeviceID]];                
            }
            completeBlock(YES);
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
            return @" Đang xử lý ";
            break;
        case pending:
            return @" Chờ duyệt ";
            break;
        case private_:
            return @" Gửi admin ";
            break;
        case close_:
            return @" Đã xử lý ";
            break;
        case unpublish:
            return @" Đã đóng ";
        default:
            break;
    }
    return @" Đang xử lý ";
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

+ (NSArray*) getListAdminUserWithCompletionBlock:(AppArrayCompleteBlock) completeBlock{
    NSArray *listAdmin;
    PFQuery *query = [PFUser query];
    [query whereKey:@"group" equalTo:@"admin"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        completeBlock(objects);
    }];
    return listAdmin;
}

+ (void) pushToAdminWithDictionary:(NSDictionary*) obj {
    [PFController getListAdminUserWithCompletionBlock:^(NSArray *result) {
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"owner" containedIn:result];
        PFPush *push = [[PFPush alloc] init];
        [push setQuery:pushQuery];
        [push setData:obj];
        [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
        }];
    }];
}

+ (NSDictionary*) pushDictWithObject:(PFObject*) object {
    NSMutableDictionary *pushDict = [NSMutableDictionary dictionary];
    [pushDict setObject:object[@"title"] forKey:@"alert"];
    [pushDict setObject:@"Increment" forKey:@"badge"];
    [pushDict setObject:[object parseClassName] forKey:@"class"];
    [pushDict setObject:[object objectId] forKey:@"objectId"];
    return pushDict;
}

+ (void) reloadReadNotice {
    PFQuery *query = [PFQuery queryWithClassName:@"Notification"];
    [query whereKey:@"is_read" equalTo:[NSNumber numberWithBool:NO]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:READ_CHANGE_NOTIFICATION object:[NSNumber numberWithInteger:objects.count]];
    }];
}
@end
