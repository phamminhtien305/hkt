//
//  HeaderAddReportView.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "HeaderAddReportView.h"
#import "ReportObject.h"

@implementation HeaderAddReportView


+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 40);
}

-(void)configHeader:(id)data{
    if([data isKindOfClass:[ReportObject class]]){
        ReportObject *item = (ReportObject *)data;
        [lbTitle setText:[item getHeaderName]];
    }else if([data isKindOfClass:[NSString class]]){
        [lbTitle setText:data];
    }
}

@end
