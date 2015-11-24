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
    id item_;
    __weak IBOutlet UIButton *btnStateReport;
    __weak IBOutlet UIScrollView *mainScroll;
    
    __weak IBOutlet UIButton *btnFollow, *btnShare, *btnRequest, *btnCreateEvent;
    __weak IBOutlet UIView *locationView;
    
    id _event;
}

-(id)initWithReportItem:(ReportItemObject *)item;

-(void)updateWithEvent:(id)event;


@end
