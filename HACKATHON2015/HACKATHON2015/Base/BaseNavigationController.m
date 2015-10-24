//
//  BaseNavigationController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AddReportViewController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(DETECT_OS7){
        [self.navigationBar  setTranslucent:NO];
    }
    navigationBar = [NavigationbarView newView];
    navigationBar.delegate = self;
    [self.view addSubview:navigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];

}

-(void)updateTitle:(NSString *)title{
    [navigationBar updateTitle:title];
}

#pragma mark - Navigation Bar Delegate
-(void)backHandle:(id)sender{
    [self popViewControllerAnimated:YES];
}

-(void)addReportHandle:(id)sender{
    AddReportViewController *report = [[AddReportViewController alloc] initUsingNib];
    [self pushViewController:report animated:YES];
}


-(NavigationbarView *)getNavigationBarView{
    return navigationBar;
}

-(void)hiddenNavigationButtonLeft:(BOOL)hidden{
    [navigationBar.btnLeft setHidden:hidden];
}

-(void)hiddenNavigationButtonRight:(BOOL)hidden{
    [navigationBar.btnRight setHidden:hidden];
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
