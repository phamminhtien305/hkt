//
//  ReportItemObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportItemObject.h"
#import <Parse/Parse.h>

@implementation ReportItemObject

+ (NSArray*) createListDataFromPFObject:(NSArray*) listPFObject {
    if (![listPFObject isKindOfClass:[NSArray class]])
        return nil;
    NSMutableArray *listData = [NSMutableArray array];
    int index = 0;
    for (PFObject* pfobject in listPFObject) {
        ReportItemObject *object = [[self alloc] initWithPFObject:pfobject];
        object.order = index;
        [listData addObject:object];
//        PFRelation *relationUser = [pfobject relationForKey:@"user_follower"];
        
//        NSArray *listUserFollow = [[relationUser query] findObjects];
//        [relationUser query].cachePolicy = kPFCachePolicyCacheThenNetwork;
//        object.follower = (int)[listUserFollow count];
//        object.isFollowed = NO;
//        for (PFUser *user in listUserFollow) {
//            if ([user.username isEqualToString:[PFUser currentUser].username]) {
//                object.isFollowed = YES;
//            }
//        }
        index ++;
        
    }
    return listData;
}

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

-(NSDictionary *)getLocationDic{
    if([self.pfObject objectForKey:@"location"]){
        NSDictionary * location = [self.pfObject objectForKey:@"location"];
        return location;
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
        return location.longitude ;
    }
    return 0.0;
}

-(BOOL)shareWithPublic{
    if([self.pfObject objectForKey:@"share_public"]){
        return [[self.pfObject objectForKey:@"share_public"] boolValue];
    }
    return NO;
}

-(REPORT_STATE)state{
    if([self.pfObject objectForKey:@"state"]){
        NSString *state = [self.pfObject objectForKey:@"state"];
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
    if([self.pfObject objectForKey:@"iamges"]){
        return [self.pfObject objectForKey:@"images"];
    }
    return nil;
}

-(NSString *)getFistImage{
    if([self.pfObject objectForKey:@"images"]){
        NSArray *items =  [self.pfObject objectForKey:@"images"];
        if([items count] > 0){
            return [items firstObject];
        }
    }
    return nil;
}

-(int)getFollower{
    return self.follower;
}


-(BOOL)checkFollow{
    return self.isFollowed;
}

@end
