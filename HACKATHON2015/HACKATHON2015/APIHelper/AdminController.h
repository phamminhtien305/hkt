//
//  AdminController.h
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportItemObject.h";
@interface AdminController : NSObject

+ (void) changeStateActionWithWithReportObject:(ReportItemObject*) reportObject;
@end
