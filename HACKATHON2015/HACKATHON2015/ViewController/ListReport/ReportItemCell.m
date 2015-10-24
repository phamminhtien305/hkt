//
//  ReportItemCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportItemCell.h"
#import "PFController.h"
#import "UIActionSheet+Blocks.h"
#import "NewsObject.h"

@implementation ReportItemCell

-(void)awakeFromNib{
    [super awakeFromNib];
    btnState.layer.cornerRadius = 2;
    btnState.layer.masksToBounds = YES;
    [btnState addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) stateClick:(id) sender {
    if ([PFController isAdmin]) {
        NSMutableArray *listAction = [NSMutableArray array];
        for (REPORT_STATE i = pending; i <= unpublish; i++) {
            [listAction addObject:[PFController textStringFromState:i]];
        }
        [UIActionSheet showInView:[[[UIApplication sharedApplication] delegate] window]
                        withTitle:@"Chuyển trạng thái report"
                cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:listAction tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
            
        }];
    }
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
