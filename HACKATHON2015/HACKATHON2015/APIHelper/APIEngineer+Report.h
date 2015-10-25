//
//  APIEngineer+Report.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer.h"

@interface APIEngineer (Report)

-(void)getReportContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

-(void)getReportsItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

-(void)getNewsItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

-(void)getReportsUserItemContentOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

@end
