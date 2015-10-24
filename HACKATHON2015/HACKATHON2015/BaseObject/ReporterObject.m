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
    if([self.objectDict objectForKey:@"first_name"]){
        return [self.objectDict objectForKey:@"first_name"];
    }
    return @"";
}

-(NSString *)getReporterLastName{
    if([self.objectDict objectForKey:@"last_name"]){
        return [self.objectDict objectForKey:@"last_name"];
    }
    return @"";
}

-(NSString *)getReporterEmail{
    if([self.objectDict objectForKey:@"email"]){
        return [self.objectDict objectForKey:@"email"];
    }
    return @"";
}

-(NSString *)getReporterPhone{
    if([self.objectDict objectForKey:@"phone"]){
        return [self.objectDict objectForKey:@"phone"];
    }
    return @"";
}
    

@end
