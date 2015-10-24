//
//  InfoCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 44);
}

-(void)configCell:(id)data{
    if([data isKindOfClass:[NSString class]]){
        [lbTitle setText:data];
    }
}


@end
