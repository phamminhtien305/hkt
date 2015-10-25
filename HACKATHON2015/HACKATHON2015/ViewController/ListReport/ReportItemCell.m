//
//  ReportItemCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportItemCell.h"
#import "PFController.h"
#import "AdminController.h"
#import "UIActionSheet+Blocks.h"
#import "NewsObject.h"

@implementation ReportItemCell

-(void)awakeFromNib{
    [super awakeFromNib];
    btnState.layer.cornerRadius = 2;
    btnState.layer.masksToBounds = YES;
    btnFollow.imageEdgeInsets = UIEdgeInsetsMake(0, 0.6, 0, 0.6);
    btnRequest.imageEdgeInsets = UIEdgeInsetsMake(0, 0.6, 0, 0.6);
    btnShare.imageEdgeInsets = UIEdgeInsetsMake(0, 0.6, 0, 0.6);
    
    [btnState addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) stateClick:(id) sender {
    [AdminController changeStateActionWithWithReportObject:item];
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
        [createDate setText:[item createDate]];
        [btnState setTitle:[PFController textStringFromState:[item state]] forState:UIControlStateNormal];
        if([item getFistImage]){
            [thumbnail sd_setImageWithURL:[NSURL URLWithString:[item getFistImage]] placeholderImage:nil];
        }
        if([item state] == open_){
            [btnState setBackgroundColor:BACKGROUND_STATE_OPENED];
        }else if([item state] == pending){
            [btnState setBackgroundColor:BACKGROUND_STATE_SUBMITED];
        }else if([item state] == close_){
            [btnState setBackgroundColor:BACKGROUND_STATE_CLOSED];
        }else if([item state] == unpublish){
            [btnState setBackgroundColor:BACKGROUND_STATE_CLOSED];
        }else if([item state] == private_){
            [btnState setBackgroundColor:BACKGROUND_STATE_CLOSED];
        }
    }
}

@end
