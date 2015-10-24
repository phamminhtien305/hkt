//
//  AddReportViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "AddReportViewController.h"

@interface AddReportViewController ()

@end

@implementation AddReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    controller = [[AddReportController alloc] initWithTargetCollection:collectionView];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:NO];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:NO];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:YES];
}

@end
