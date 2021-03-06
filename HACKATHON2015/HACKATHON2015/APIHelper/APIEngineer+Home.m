//
//  APIEngineer+Home.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer+Home.h"
#import <Parse/Parse.h>

@implementation APIEngineer (Home)

-(void)getHomeContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    [self requestParseWithLink:HOME_URL withCompleteBlock:^(id result, BOOL isCache) {
        onComplete(result, NO);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
