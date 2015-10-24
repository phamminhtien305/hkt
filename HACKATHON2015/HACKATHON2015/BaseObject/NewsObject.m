//
//  NewsObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "NewsObject.h"

@implementation NewsObject


-(NSString *)getTitle{
    if([self.pfObject objectForKey:@"title"]){
        return [self.pfObject objectForKey:@"title"];
    }
    return @"";
}

-(NSString *)getDescription{
    if([self.pfObject objectForKey:@"description"]){
        return [self.pfObject objectForKey:@"description"];
    }
    return @"";
}

-(NSString *)getID{
    if([self.pfObject objectForKey:@"objectId"]){
        return [self.pfObject objectForKey:@"objectId"];
    }
    return @"";
}

-(id)getLocation{
    if([self.pfObject objectForKey:@"location"]){
        return [self.pfObject objectForKey:@"location"];
    }
    return nil;
}


-(float)getLatitude{
    if([self.pfObject objectForKey:@"location"]){
        PFGeoPoint * location = [self.pfObject objectForKey:@"location"];
        return location.latitude;
    }
    return 0.0;
}


-(float)getLongtitude{
    if([self.pfObject objectForKey:@"location"]){
        PFGeoPoint * location = [self.pfObject objectForKey:@"location"];
        return location.longitude;
    }
    return 0.0;
}

-(NSString *)createTime{
    if([self.pfObject objectForKey:@"createdAt"]){
        return [self.pfObject objectForKey:@"createdAt"];
    }
    return @"";
}


-(NSString *)updateTime{
    if([self.pfObject objectForKey:@"updatedAt"]){
        return [self.pfObject objectForKey:@"updatedAt"];
    }
    return @"";
}

-(REPORT_STATE)state{
    if([self.pfObject objectForKey:@"state"]){
        NSString *state = [self.pfObject objectForKey:@"state"];
        if([state isEqualToString:@"pending"]){
            return pending;
        }else if([state isEqualToString:@"private"]){
            return private_;
        }else if([state isEqualToString:@"open"]){
            return open_;
        }else if([state isEqualToString:@"close"]){
            return close_;
        }else if([state isEqualToString:@"unpublish"]){
            return unpublish;
        }
    }
    return pending;
}

-(NSArray *)getImages{
    if([self.pfObject objectForKey:@"images"]){
        return [self.pfObject objectForKey:@"images"];
    }
    return nil;
}

-(NSString*)getFirstImage{
    if([self.pfObject objectForKey:@"images"]){
        NSArray *arr = [self.pfObject objectForKey:@"images"];
        if([arr count] > 0){
            NSString *url = [arr objectAtIndex:0];
            return url;
        }
    }
    return nil;
}

-(NSString*)getImage{
    if([self.pfObject objectForKey:@"images"]){
        NSArray *arr = [self.pfObject objectForKey:@"images"];
        if(self.order < [arr count]){
            NSString *url = [arr objectAtIndex:self.order];
            return url;
        }
    }
    return nil;
}
@end
