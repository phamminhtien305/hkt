//
//  ListFavoriteViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "PageListReportViewController.h"

@interface PageListReportViewController ()

@end

@implementation PageListReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    controller = [[ListReportController alloc] initWithTargetCollection:collectionView withListItem:[MainViewController shareMainViewController].listReporterItem];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [[MainViewController getRootNaviController] updateTitle:@"Report"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
