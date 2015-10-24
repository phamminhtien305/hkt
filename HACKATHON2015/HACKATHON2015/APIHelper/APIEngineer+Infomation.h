//
//  APIEngineer+Infomation.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer.h"

@interface APIEngineer (Infomation)

-(void)getInfoAppOnComplete:(AppResultCompleteBlock)onComplete onError:(AppResultErrorBlock)errorBlock;

@end
