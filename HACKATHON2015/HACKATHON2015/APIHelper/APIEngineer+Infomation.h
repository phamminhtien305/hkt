//
//  APIEngineer+Infomation.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer.h"

@interface APIEngineer (Infomation)

-(void)getHotLines:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

-(void)getLocationService:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

@end
