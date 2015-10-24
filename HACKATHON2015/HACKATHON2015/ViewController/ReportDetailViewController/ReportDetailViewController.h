//
//  ReportDetailViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"

@interface ReportDetailViewController : BaseViewController
{
    __weak IBOutlet UILabel *lbTitle, *lbCreateDate, *lbReporter;
    __weak IBOutlet UITextView *textDescription;
    __weak IBOutlet UIImageView *imageReport;
    ReportItemObject *reportItem;
    __weak IBOutlet UIButton *btnStateReport;
    __weak IBOutlet UIScrollView *mainScroll;
}

-(id)initWithReportItem:(ReportItemObject *)item;



@end
