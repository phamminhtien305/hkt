//
//  PFController.h
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;
@interface PFController : NSObject
+ (void) registerPFUser;
+ (BOOL) isAnonymous;
+ (BOOL) isAdmin;
+ (NSString*) textStringFromState:(REPORT_STATE) state;
+ (NSString*) stringFromState:(REPORT_STATE) state;
+ (NSDictionary*) pfObjectToDict:(PFObject*) object;
@end
