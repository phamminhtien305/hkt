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
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query orderByDescending:@"createdAt"];
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
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query whereKey:@"state" containedIn:[[NSArray alloc] initWithObjects:@"open",@"close",@"pending", nil]];
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
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query whereKey:@"state" containedIn:[[NSArray alloc] initWithObjects:@"open", nil]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}


-(void)getUsersReportItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"Report"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query whereKey:@"owner" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            errorBlock(error);
        }else{
            onComplete(objects, NO);
        }
    }];
}


-(void)getMyFavoriteReportsItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"Report"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
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
