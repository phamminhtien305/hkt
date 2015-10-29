//
//  ReportCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportCell.h"

@implementation ReportCell


+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 44);
}

-(void)configCell:(NSString *)title withThumb:(NSString *)thumb{
    [lbTitle setText:title];
    [thumbNail sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:ERROR_UIIMAGE];
}

-(void)updateCell{
    if(self.isLastCell){
        [lineImage setHidden:YES];
    }else{
        [lineImage setHidden:NO];
    }
}
@end
