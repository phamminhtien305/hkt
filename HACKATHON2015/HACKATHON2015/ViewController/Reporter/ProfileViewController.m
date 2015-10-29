//
//  ReporterViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ProfileViewController.h"
#import <JSONKit/JSONKit.h>
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[MainViewController getRootNaviController] updateTitle:@"Hồ Sơ"];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
    
    controller = [[ProfileController alloc] initWithTargetCollection:collectionView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
