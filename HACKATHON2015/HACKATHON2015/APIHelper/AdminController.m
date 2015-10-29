//
//  AdminController.m
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "AdminController.h"
#import "PFController.h"
#import "NotificationController.h"
#import "UIActionSheet+Blocks.h"
#import <Parse/Parse.h>

@implementation AdminController
+ (void) changeStateActionWithWithReportObject:(ReportItemObject*) reportObject
{
    if ([PFController isAdmin]) {
        NSMutableArray *listAction = [NSMutableArray array];
        for (REPORT_STATE i = pending; i <= unpublish; i++) {
            [listAction addObject:[PFController textStringFromState:i]];
        }
        [UIActionSheet showInView:[[[UIApplication sharedApplication] delegate] window]
                        withTitle:@"Chuyển trạng thái report"
                cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:listAction tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                    [self updatePFObjectWithState:buttonIndex withReportItemObject:reportObject];
                }];
    }
}

+ (void) updatePFObjectWithState:(REPORT_STATE) newState
            withReportItemObject:(ReportItemObject*) reportObject {
    REPORT_STATE oldState = [reportObject state];
    if (oldState != newState) {
        PFQuery *query = [PFQuery queryWithClassName:@"Report"];
        query.cachePolicy =     kPFCachePolicyCacheThenNetwork;
        [query whereKey:@"objectId" equalTo:[reportObject getID]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            [object setObject:[PFController stringFromState:newState] forKey:@"state"];
            // Reload by state change
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:STATE_CHANGE_NOTIFICATION object:[PFController stringFromState:newState]];
            }];
        }];
    }
}
@end
