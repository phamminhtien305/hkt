//
//  SegmentCellListAlbum.m
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "SegmentCell.h"

@implementation SegmentCell


+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width/3, 34);
}

-(void)configCell:(NSString *)title withSelected:(BOOL)selected{
    if(selected){
        [selectedView setHidden:NO];
    }else{
        [selectedView setHidden:YES];
    }
    [lbtilte setText:title];
}


@end
