//
//  ReportItemCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportItemCell.h"

@implementation ReportItemCell

-(void)awakeFromNib{
    [super awakeFromNib];
    btnState.layer.cornerRadius = 2;
    btnState.layer.masksToBounds = YES;
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 250);
}

-(void)configCell:(id)data{
    if(data && [data isKindOfClass:[ReportItemObject class]]){
        item = (ReportItemObject *)data;
        [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, [DeviceHelper getWinSize].width - 40, 35)];
        [lbTitle setText:[item getTitle]];
        [lbTitle sizeToFit];
        [lbDescription setText:[item getDescription]];
        [createDate setText:[item createTime]];
        if([item getFistImage]){
            [thumbnail sd_setImageWithURL:[NSURL URLWithString:[item getFistImage]] placeholderImage:nil];
        }
        if([item state] == open_){
            [btnState setTitle:@"Opened" forState:UIControlStateNormal];
            [btnState setBackgroundColor:BACKGROUND_STATE_OPENED];
        }else if([item state] == pending){
            [btnState setTitle:@"Pending" forState:UIControlStateNormal];
            [btnState setBackgroundColor:BACKGROUND_STATE_SUBMITED];
        }else if([item state] == close_){
            [btnState setTitle:@"Closed" forState:UIControlStateNormal];
            [btnState setBackgroundColor:BACKGROUND_STATE_CLOSED];
        }else if([item state] == unpublish){
            [btnState setTitle:@"UnPublish" forState:UIControlStateNormal];
            [btnState setBackgroundColor:BACKGROUND_STATE_CLOSED];
        }else if([item state] == private_){
            [btnState setTitle:@"Private" forState:UIControlStateNormal];
            [btnState setBackgroundColor:BACKGROUND_STATE_CLOSED];
        }

    }
}

@end
