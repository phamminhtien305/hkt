//
//  ReportItemCell.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface ReportItemCell : BaseCollectionViewCell
{
    ReportItemObject *item;
    
    __weak IBOutlet UILabel *lbTitle;
    __weak IBOutlet UILabel *lbDescription;
    __weak IBOutlet UILabel *createDate;
    __weak IBOutlet UILabel *lbReporter;
    __weak IBOutlet UIImageView *thumbnail;
    __weak IBOutlet UIButton *btnState, *btnFollow, *btnShare, *btnRequest;
}
@end
