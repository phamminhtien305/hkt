//
//  GetIp.h
//  AppFilm
//
//  Created by Apple on 3/5/15.
//  Copyright (c) 2015 appvn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFGetIp : NSObject

+ (AFGetIp*)sharedInstance;
- (NSString *)getIPAddress:(BOOL)preferIPv4;
- (NSDictionary *)getIPAddresses;

@end
