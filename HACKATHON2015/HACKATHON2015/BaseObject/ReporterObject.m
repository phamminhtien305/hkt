//
//  ReporterObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReporterObject.h"

@implementation ReporterObject


-(NSString *)getReporterFirstName{
    if([self.pfObject objectForKey:@"first_name"]){
        return [self.pfObject objectForKey:@"first_name"];
    }
    return @"";
}

-(NSString *)getReporterLastName{
    if([self.pfObject objectForKey:@"last_name"]){
        return [self.pfObject objectForKey:@"last_name"];
    }
    return @"";
}

-(NSString *)getReporterEmail{
    if([self.pfObject objectForKey:@"email"]){
        return [self.pfObject objectForKey:@"email"];
    }
    return @"";
}

-(NSString *)getReporterPhone{
    if([self.pfObject objectForKey:@"phone"]){
        return [self.pfObject objectForKey:@"phone"];
    }
    return @"";
}
    

@end
