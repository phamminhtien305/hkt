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

-(id)initWithListUserReport{
    self = [super initUsingNib];
    if(self){
        type = USER_REPORT;
    }
    return self;
}

-(id)initWithListUserRequest{
    self = [super initUsingNib];
    if(self){
        type = USER_REQUEST;
    }
    return self;
}


-(id)initWithListUserFollow{
    self = [super initUsingNib];
    if(self){
        type = USER_FOLLOW_REPORT;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(type == LIST_REPORT_NONE){
        controller = [[ListReportController alloc] initWithTargetCollection:collectionView withListItem:[MainViewController shareMainViewController].listReporterItem];
    }else{
        controller = [[ListReportController alloc] initWithTargetCollection:collectionView withListType:type];  
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

//    [[MainViewController getRootNaviController] updateTitle:@"Report"];
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
