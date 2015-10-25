//
//  NewsCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "NotificationCell.h"
#import "NotificationObject.h"

@implementation NotificationCell

-(void)awakeFromNib{
    [super awakeFromNib];
    thumbnail.layer.cornerRadius = thumbnail.frame.size.width/2;
    thumbnail.layer.masksToBounds = YES;
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 60);
}

-(void)configCell:(id)data{
    if(data && [data isKindOfClass:[NotificationObject class]]){
        item = (NotificationObject *)data;
        [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, [DeviceHelper getWinSize].width - 140, 42)];
        [lbTitle setText:[item getTitle]];
        [lbTitle sizeToFit];
        [createDate setText:[item createDate]];
        [thumbnail sd_setImageWithURL:[NSURL URLWithString:[item pfObject][@"thumbnail"]] placeholderImage:nil];
        if (![[item pfObject][@"is_read"] boolValue]) {
            self.backgroundColor = BACKGROUND_NOTIFICATION_NOTREAD;
        }
        else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
