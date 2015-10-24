//
//  ReportObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportObject.h"

@implementation ReportObject

-(NSString *)getHeaderName{
    if([self.objectDict objectForKey:@"header_name"]){
        return [self.objectDict objectForKey:@"header_name"];
    }
    return @"";
}

-(NSArray *)getListReport{
    if([self.objectDict objectForKey:@"items"]){
        return [self.objectDict objectForKey:@"items"];
    }
    return nil;
}


@end
