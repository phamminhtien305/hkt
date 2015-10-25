//
//  HeaderInfoView.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "HeaderInfoView.h"

@implementation HeaderInfoView

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 20);
}

-(void)configHeader:(id)data{
    [self setBackgroundColor:BACKGROUND_COLLECTION];
    if([data isKindOfClass:[NSString class]]){
        [lbTitle setText:data];
    }
}

@end
