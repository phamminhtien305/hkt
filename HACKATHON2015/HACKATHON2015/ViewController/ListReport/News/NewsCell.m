//
//  NewsCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 120);
}

-(void)configCell:(id)data{
    if(data && [data isKindOfClass:[ReportItemObject class]]){
        item = (ReportItemObject *)data;
        [lbTitle setText:[item getTitle]];
        [lbDescription setText:[item getDescription]];
        [createDate setText:[item createTime]];
        if([item getThumbnail]){
            [thumbnail sd_setImageWithURL:[NSURL URLWithString:[item getThumbnail]] placeholderImage:nil];
        }
    }
}

@end
