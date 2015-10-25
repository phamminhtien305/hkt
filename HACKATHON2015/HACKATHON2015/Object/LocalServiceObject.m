//
//  LocalServiceObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/25/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "LocalServiceObject.h"

@implementation LocalServiceObject

-(NSString *)getTitle{
    if(self.pfObject && [self.pfObject objectForKey:@"title"]){
        return [self.pfObject objectForKey:@"title"];
    }
    return @"";
}

-(NSArray *)listPoint{
    if([self.pfObject objectForKey:@"location"]){
        return [self.pfObject objectForKey:@"location"];
    }
    return nil;
}


@end
