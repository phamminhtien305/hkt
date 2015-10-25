//
//  APIEngineer+Report.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer+Report.h"
#import <Parse/Parse.h>

@implementation APIEngineer (Report)


-(void)getReportContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"NEWREPORT"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}


-(void)getReportsItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"Report"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}


-(void)getNewsItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}


-(void)getReportsUserItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"Report"];
    [query whereKey:@"owner" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}



@end
