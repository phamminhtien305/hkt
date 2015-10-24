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
@end
