//
//  InfoCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "InfoCell.h"
#import "HotLineObject.h"
#import "LocalServiceObject.h"

@implementation InfoCell

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 44);
}

-(void)configCell:(id)data{
    if([data isKindOfClass:[NSString class]]){
        [lbTitle setText:data];
    }else if ([data isKindOfClass:[NSDictionary class]]){
        objectDic = data;
        [lbTitle setText:[(NSDictionary *)objectDic objectForKey:@"title"]];
        [lbValue setText:[(NSDictionary *)objectDic objectForKey:@"value"]];
    }else if([data isKindOfClass:[LocalServiceObject class]]){
        objectDic = data;
        [lbTitle setText:[(NSDictionary *)objectDic objectForKey:@"title"]];
    }else if([data isKindOfClass:[HotLineObject class]]){
        objectDic = data;
        [lbTitle setText:[(NSDictionary *)objectDic objectForKey:@"title"]];
        [lbValue setText:[(NSDictionary *)objectDic objectForKey:@"phone"]];
    }
}


@end
