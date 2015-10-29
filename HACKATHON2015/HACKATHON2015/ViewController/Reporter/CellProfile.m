//
//  CellProfile.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/29/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "CellProfile.h"

@implementation CellProfile


+(CGSize)getSize{
    return CGSizeMake([DeviceHelper  getWinSize].width, 40);
}

-(void)configCell:(id)data{
    if(data && [data isKindOfClass:[NSDictionary class]]){
        [lbTitle setText:[data objectForKey:@"title"]];
        [thumbNail setImage:[UIImage imageNamed:[data objectForKey:@"thumb"]]];
    }
}
@end
