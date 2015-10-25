//
//  HotLineObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/25/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "HotLineObject.h"

@implementation HotLineObject

-(NSString *)getTitle{
    if(self.pfObject && [self.pfObject objectForKey:@"title"]){
        return [self.pfObject objectForKey:@"title"];
    }
    return @"";
}

-(NSString *)getDescription{
    if(self.pfObject && [self.pfObject objectForKey:@"description"]){
        return [self.pfObject objectForKey:@"description"];
    }
    return @"";
}

-(NSString *)getHotLine{
    if(self.pfObject && [self.pfObject objectForKey:@"phone"]){
        return [self.pfObject objectForKey:@"phone"];
    }
    return @"";
}


@end
