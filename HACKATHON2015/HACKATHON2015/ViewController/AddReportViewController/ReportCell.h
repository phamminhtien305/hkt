//
//  ReportCell.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface ReportCell : BaseCollectionViewCell
{
    __weak IBOutlet UILabel *lbTitle;
    __weak IBOutlet UIImageView *lineImage, *thumbNail;
}

@property BOOL isLastCell;

-(void)updateCell;

-(void)configCell:(NSString *)title withThumb:(NSString *)thumb;


@end
