//
//  APIEngineer+Infomation.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer+Infomation.h"
#import <Parse/Parse.h>

@implementation APIEngineer (Infomation)

-(void)getHotLines:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"SupportNumber"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"------>");
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}

-(void)getLocationService:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"SupportLocation"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}


@end
