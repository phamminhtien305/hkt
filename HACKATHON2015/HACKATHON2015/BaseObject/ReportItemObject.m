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
    return [self getUserFirstName];
}

-(NSString *)getUserFirstName{
    if([self.objectDict objectForKey:@"user_first_name"]){
        return [self.objectDict objectForKey:@"user_first_name"];
    }
    return @"";
}

-(NSString *)getUserLastName{
    if([self.objectDict objectForKey:@"user_last_name"]){
        return [self.objectDict objectForKey:@"user_last_name"];
    }
    return @"";
}

-(NSString *)getUserPhone{
    if([self.objectDict objectForKey:@"user_phone"]){
        return [self.objectDict objectForKey:@"user_phone"];
    }
    return @"";
}

-(NSString *)getUserEmail{
    if([self.objectDict objectForKey:@"user_email"]){
        return [self.objectDict objectForKey:@"user_email"];
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

-(float)getLatitude{
    if([self.objectDict objectForKey:@"latitude"]){
        return [[self.objectDict objectForKey:@"latitude"] floatValue];
    }
    return 0.0;
}


-(float)getLongtitude{
    if([self.objectDict objectForKey:@"longtitude"]){
        return [[self.objectDict objectForKey:@"longtitude"] floatValue];
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
        }else if([state isEqualToString:@"slose"]){
            return close_;
        }else if ([state isEqualToString:@"private"]){
            return private_;
        }else if([state isEqualToString:@"unpublish"]){
            return unpublish;
        }
    }
    return pending;
}


-(BOOL)isNew{
    if([self.objectDict objectForKey:@"isNew"]){
        return [[self.objectDict objectForKey:@"isNew"] boolValue];
    }
    return NO;
}

-(NSString *)getThumbnail{
    if([self.objectDict objectForKey:@"thumbnail"]){
        return [self.objectDict objectForKey:@"thumbnail"];
    }
    return nil;
}

@end
