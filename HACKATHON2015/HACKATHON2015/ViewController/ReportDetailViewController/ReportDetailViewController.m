//
//  ReportDetailViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "ReportItemObject.h"
#import "NewsObject.h"
#import "PFController.h"
#import "MapViewController.h"

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController

-(id)initWithReportItem:(id)item{
    self = [super initUsingNib];
    if(self){
        item_ = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:NO];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:YES];
    
    btnShare.imageEdgeInsets = UIEdgeInsetsMake(0, 0.6, 0, 0.6);
    btnFollow.imageEdgeInsets = UIEdgeInsetsMake(0, 0.6, 0, 0.6);
    btnRequest.imageEdgeInsets = UIEdgeInsetsMake(0, 0.6, 0, 0.6);
    
    [textDescription setFrame:CGRectMake(textDescription.frame.origin.x, textDescription.frame.origin.y, textDescription.frame.size.width, 250)];
}

-(void)configButtonStateReport{
    btnStateReport.layer.cornerRadius = 2;
    btnStateReport.layer.masksToBounds = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [btnStateReport setAlpha:1.0];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([item_ isKindOfClass:[ReportItemObject class]]){
        [self updateForReport];
    }else{
        [self updateForNews];
    }
    [self configButtonStateReport];
    [mainScroll setContentSize:CGSizeMake(mainScroll.frame.size.width, lbReporter.frame.origin.y + lbReporter.frame.size.height + 30)];
}

-(void)updateForNews{
    NewsObject *newItem = (NewsObject *)item_;
    NSString *title  = [newItem getTitle];
    [[MainViewController getRootNaviController] updateTitle:title];
    
    [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, lbTitle.frame.size.width, 40)];
    [lbTitle setText:[newItem getTitle]];
    [lbTitle sizeToFit];
    [lbCreateDate setText:[newItem createDate]];
    //    [lbReporter setText:[NSString stringWithFormat:@"Reporter: %@ %@",[reportItem getUserFirstName], [reportItem getUserLastName]]];
    [textDescription setText:[newItem getDescription]];

    [btnStateReport setTitle:[PFController textStringFromState:[newItem state]] forState:UIControlStateNormal];
    [btnStateReport sizeToFit];
    [btnStateReport setFrame:CGRectMake([DeviceHelper getWinSize].width - 10 - btnStateReport.frame.size.width, btnStateReport.frame.origin.y, btnStateReport.frame.size.width, 20)];
    
    if([newItem getFirstImage]){
        [imageReport sd_setImageWithURL:[NSURL URLWithString:[newItem getFirstImage]] placeholderImage:nil];
    }
    if([newItem state] == open_){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_OPENED];
    }else if([newItem state] == pending){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_SUBMITED];
    }else if([newItem state] == close_){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }else if([newItem state] == private_){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }else if([newItem state] == unpublish){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }
    [textDescription sizeToFit];
    if(![item_ getLocation]){
        [locationView setAlpha:0.0];
    }
    [locationView setFrame:CGRectMake(locationView.frame.origin.x, textDescription.frame.origin.y + textDescription.frame.size.height, locationView.frame.size.width, locationView.frame.size.height)];
    
    [lbReporter setFrame:CGRectMake(lbReporter.frame.origin.x, locationView.frame.origin.y + locationView.frame.size.height, lbReporter.frame.size.width, lbReporter.frame.size.height)];
}

-(void)updateForReport{
    ReportItemObject *reportItem = (ReportItemObject *)item_;
    
    NSString *title  = [reportItem getTitle];
    [[MainViewController getRootNaviController] updateTitle:title];
    
    [lbTitle setFrame:CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, lbTitle.frame.size.width, 40)];
    [lbTitle setText:[reportItem getTitle]];
    [lbTitle sizeToFit];
    [lbCreateDate setText:[reportItem createDate]];
//    [lbReporter setText:[NSString stringWithFormat:@"Reporter: %@ %@",[reportItem getUserFirstName], [reportItem getUserLastName]]];
    [textDescription setText:[reportItem getDescription]];
    
    [btnStateReport setTitle:[PFController textStringFromState:[reportItem state]] forState:UIControlStateNormal];
    [btnStateReport sizeToFit];
    [btnStateReport setFrame:CGRectMake([DeviceHelper getWinSize].width - 10 - btnStateReport.frame.size.width, btnStateReport.frame.origin.y, btnStateReport.frame.size.width, 20)];
    
    
    if([reportItem getFistImage]){
        [imageReport sd_setImageWithURL:[NSURL URLWithString:[reportItem getFistImage]] placeholderImage:nil];
    }
    
    if([reportItem state] == open_){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_OPENED];
    }else if([reportItem state] == pending){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_SUBMITED];
    }else if([reportItem state] == close_){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }else if([reportItem state] == private_){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }else if([reportItem state] == unpublish){
        [btnStateReport setBackgroundColor:BACKGROUND_STATE_CLOSED];
    }
    [textDescription sizeToFit];
    [textDescription setFrame:CGRectMake(textDescription.frame.origin.x, textDescription.frame.origin.y, textDescription.frame.size.width, textDescription.frame.size.height + 20)];
    
    [locationView setFrame:CGRectMake(locationView.frame.origin.x, textDescription.frame.origin.y + textDescription.frame.size.height, locationView.frame.size.width, locationView.frame.size.height)];
    
    [lbReporter setFrame:CGRectMake(lbReporter.frame.origin.x, locationView.frame.origin.y + locationView.frame.size.height, lbReporter.frame.size.width, lbReporter.frame.size.height)];
}


-(IBAction)clickPosition:(id)sender{
    MapViewController *map = [[MapViewController alloc] initWithItem:item_];
    [[MainViewController getRootNaviController] pushViewController:map animated:YES];
}


@end
