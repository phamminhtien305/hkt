//
//  ReportItemObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportItemObject.h"

@implementation ReportItemObject

-(NSString *)getTitle{
    if([self.objectDict objectForKey:@"title"]){
        return [self.objectDict objectForKey:@"title"];
    }
    return @"";
}

-(NSString *)getDescription{
    if([self.objectDict objectForKey:@"description"]){
        return [self.objectDict objectForKey:@"description"];
    }
    return @"";
}

-(NSString *)getID{
    if([self.objectDict objectForKey:@"objectId"]){
        return [self.objectDict objectForKey:@"objectId"];
    }
    return @"";
}

-(NSDictionary *)getLocationDic{
    if([self.objectDict objectForKey:@"location"]){
        NSDictionary * location = [self.objectDict objectForKey:@"location"];
        return location;
    }
    return nil;
}

-(float)getLatitude{
    if([self.objectDict objectForKey:@"location"]){
        NSDictionary * location = [self.objectDict objectForKey:@"location"];
        return [[location objectForKey:@"latitude"] floatValue];
    }
    return 0.0;
}


-(float)getLongtitude{
    if([self.objectDict objectForKey:@"location"]){
        NSDictionary * location = [self.objectDict objectForKey:@"location"];
        return [[location objectForKey:@"longitude"] floatValue];
    }
    return 0.0;
}


-(NSString *)createTime{
    if([self.objectDict objectForKey:@"createdAt"]){
        return [self.objectDict objectForKey:@"createdAt"];
    }
    return @"";
}


-(NSString *)updateTime{
    if([self.objectDict objectForKey:@"updatedAt"]){
        return [self.objectDict objectForKey:@"updatedAt"];
    }
    return @"";
}

-(BOOL)shareWithPublic{
    if([self.objectDict objectForKey:@"share_public"]){
        return [[self.objectDict objectForKey:@"share_public"] boolValue];
    }
    return NO;
}

-(REPORT_STATE)state{
    if([self.objectDict objectForKey:@"state"]){
        NSString *state = [self.objectDict objectForKey:@"state"];
        if([state isEqualToString:@"pending"]){
            return pending;
        }else if([state isEqualToString:@"open"]){
            return open_;
        }else if([state isEqualToString:@"close"]){
            return close_;
        }else if ([state isEqualToString:@"private"]){
            return private_;
        }else if([state isEqualToString:@"unpublish"]){
            return unpublish;
        }
    }
    return pending;
}

-(NSArray *)getImages{
    if([self.objectDict objectForKey:@"iamges"]){
        return [self.objectDict objectForKey:@"images"];
    }
    return nil;
}

-(NSString *)getFistImage{
    if([self.objectDict objectForKey:@"images"]){
        NSArray *items =  [self.objectDict objectForKey:@"images"];
        if([items count] > 0){
            return [items firstObject];
        }
    }
    return nil;
}

@end
