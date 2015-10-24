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
    return CGSizeMake([DeviceHelper getWinSize].width, 77);
}

-(void)configCell:(id)data{
    if(data && [data isKindOfClass:[NewsObject class]]){
        item = (NewsObject *)data;
        [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, [DeviceHelper getWinSize].width - 130, 42)];
        [lbTitle setText:[item getTitle]];
        [lbTitle sizeToFit];
        
        [lbDescription setText:[item getDescription]];
        
        [createDate setText:[item createTime]];
        
        if([item getFirstImage]){
            [thumbnail sd_setImageWithURL:[NSURL URLWithString:[item getFirstImage]] placeholderImage:nil];
        }
    }
}

@end
