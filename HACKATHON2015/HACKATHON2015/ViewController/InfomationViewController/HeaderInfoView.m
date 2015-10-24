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
    return CGSizeMake([DeviceHelper getWinSize].width, 44);
}

-(void)configHeader:(id)data{
    if([data isKindOfClass:[NSString class]]){
        [lbTitle setText:data];
    }
}

@end
