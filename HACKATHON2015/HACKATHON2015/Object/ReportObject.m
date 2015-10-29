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
    if([self.pfObject objectForKey:@"header_name"]){
        return [self.pfObject objectForKey:@"header_name"];
    }
    return @"";
}

-(NSArray *)getListReport{
    if([self.pfObject objectForKey:@"items"]){
        return [self.pfObject objectForKey:@"items"];
    }
    return nil;
}

-(NSArray *)getListReportThumbnail{
    if([self.pfObject objectForKey:@"thumbnails"]){
        return [self.pfObject objectForKey:@"thumbnails"];
    }
    return nil;
}

@end
