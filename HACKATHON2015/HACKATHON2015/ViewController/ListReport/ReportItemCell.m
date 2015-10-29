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
#import <FBSDKShareKit/FBSDKShareKit.h>

@implementation ReportItemCell

-(void)awakeFromNib{
    [super awakeFromNib];
    btnState.layer.cornerRadius = 2;
    btnState.layer.masksToBounds = YES;
    btnFollow.imageEdgeInsets = UIEdgeInsetsMake(0.2, 0.2, 0.2, 0.2);
    btnRequest.imageEdgeInsets = UIEdgeInsetsMake(0.2, 0.2, 0.2, 0.2);
    btnShare.imageEdgeInsets = UIEdgeInsetsMake(0.2, 0.2, 0.2, 0.2);

    [btnState addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) stateClick:(id) sender {
    [AdminController changeStateActionWithWithReportObject:item];
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 260);
}

-(void)configCell:(id)data{
    if(data && [data isKindOfClass:[ReportItemObject class]]){
        item = (ReportItemObject *)data;
        [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, [DeviceHelper getWinSize].width - 100, 35)];
        [lbTitle setText:[item getTitle]];
        [lbTitle sizeToFit];
        [lbDescription setText:[item getDescription]];
        [createDate setText:[item createDate]];
        
        [createDate setFrame:CGRectMake(createDate.frame.origin.x, lbTitle.frame.origin.y + lbTitle.frame.size.height + 5, createDate.frame.size.width, createDate.frame.size.height)];
        [btnState setFrame:CGRectMake(205, btnState.frame.origin.y, 107, btnState.frame.size.height)];
        [btnState setTitle:[PFController textStringFromState:[item state]] forState:UIControlStateNormal];
        [btnState sizeToFit];

        if([item getFistImage]){
            [thumbnail sd_setImageWithURL:[NSURL URLWithString:[item getFistImage]] placeholderImage:nil];
        }
        [thumbnail setFrame:CGRectMake(thumbnail.frame.origin.x, createDate.frame.origin.y + createDate.frame.size.height + 5, thumbnail.frame.size.width, 220 - (createDate.frame.origin.y + createDate.frame.size.height + 5))];
        
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
        
        [btnState setFrame:CGRectMake(self.frame.size.width - 10 - btnState.frame.size.width, btnState.frame.origin.y, btnState.frame.size.width, 24)];
        
        [UIView animateWithDuration:0.25 animations:^{
            [btnState setAlpha:1.0];
            

        }];

        [btnFollow setSelected:[item checkFollow]];
        
        [btnFollow setTitle:[NSString stringWithFormat:@" %d",[item getFollower]] forState:UIControlStateNormal];
        
    }
}


-(IBAction)handleFollow:(id)sender{
    PFObject *object = item.pfObject;
    PFRelation *relation = [item.pfObject relationForKey:@"user_follower"];
    NSArray *listUserFollower = [[relation query] findObjects];
    if([listUserFollower containsObject:[PFUser currentUser]]){
        // unfollow
        [relation removeObject:[PFUser currentUser]];
    }else{
        // follow
        [relation addObject:[PFUser currentUser]];
    }
    [object saveInBackground];
}


-(IBAction)handleShare:(id)sender{
    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];

    content.imageURL = [NSURL URLWithString: [item getFistImage]];
    content.contentDescription = [item getDescription];
    content.contentTitle = APP_NAME;
    shareDialog.shareContent = content;
    shareDialog.delegate = self;
    shareDialog.mode = FBSDKShareDialogModeAutomatic;
    [shareDialog show];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    
}

-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
}

-(IBAction)handleRequest:(id)sender{
    PFObject *object = item.pfObject;
}




@end
