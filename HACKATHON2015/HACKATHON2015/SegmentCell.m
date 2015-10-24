//
//  SegmentCellListAlbum.m
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "SegmentCell.h"

@implementation SegmentCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor clearColor]];
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width/3, 34);
}

-(void)configCell:(NSString *)title withSelected:(BOOL)selected{
    [lbtilte setTextColor:[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]];
    if(selected){
        [selectedView setHidden:NO];
        [lbtilte setTextColor:[UIColor whiteColor]];
    }else{
        [selectedView setHidden:YES];
    }
    [lbtilte setText:title];
}


@end
