//
//  ReportDetailViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportDetailViewController.h"

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController

-(id)initWithReportItem:(ReportItemObject *)item{
    self = [super initUsingNib];
    if(self){
        reportItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *title  = [reportItem getTitle];
    [[MainViewController getRootNaviController] updateTitle:title];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:NO];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:YES];
    
    btnStateReport.layer.cornerRadius = 2;
    btnStateReport.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self updateView];
    
    [mainScroll setContentSize:CGSizeMake(mainScroll.frame.size.width, lbReporter.frame.origin.y + lbReporter.frame.size.height)];
}


-(void)updateView{
    [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, lbTitle.frame.size.width, 40)];
    [lbTitle setText:[reportItem getTitle]];
    [lbTitle sizeToFit];
    [lbCreateDate setText:[reportItem createTime]];
    [lbReporter setText:[NSString stringWithFormat:@"Reporter: %@ %@",[reportItem getUserFirstName], [reportItem getUserLastName]]];
    [textDescription setText:[reportItem getDescription]];
    
    if([reportItem getThumbnail]){
        [imageReport sd_setImageWithURL:[NSURL URLWithString:[reportItem getThumbnail]] placeholderImage:nil];
    }
    if([reportItem state] == open_){
        [btnStateReport setTitle:@"Open" forState:UIControlStateNormal];
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_OPENED];
    }else if([reportItem state] == pending){
        [btnStateReport setTitle:@"Pending" forState:UIControlStateNormal];
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_SUBMITED];
    }else if([reportItem state] == close_){
        [btnStateReport setTitle:@"Close" forState:UIControlStateNormal];
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }else if([reportItem state] == private_){
        [btnStateReport setTitle:@"Private" forState:UIControlStateNormal];
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }else if([reportItem state] == unpublish){
        [btnStateReport setTitle:@"Unpublish" forState:UIControlStateNormal];
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }
    [textDescription sizeToFit];
    
    [lbReporter setFrame:CGRectMake(lbReporter.frame.origin.x, textDescription.frame.origin.y + textDescription.frame.size.height, lbReporter.frame.size.width, lbReporter.frame.size.height)];
}



@end
