//
//  APIEngineer.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "BlockConfig.h"

@interface APIEngineer : AFHTTPRequestOperationManager

@property (copy, nonatomic) AppResultProgressBlock afProgressBlock;
@property (copy, nonatomic) AppResultCompleteBlock completeBlock;
@property (copy, nonatomic) AppResultErrorBlock errorBlock;


+ (APIEngineer*) sharedInstance;

- (void)requestParseWithLink:(NSString*)link
           withCompleteBlock:(AppResultCompleteBlock)completeBlock
                  errorBlock:(AppResultErrorBlock)errorBlock;


@end
