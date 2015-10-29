//
//  InfoViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [[MainViewController getRootNaviController] updateTitle:@"Liên Hệ"];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
    
    controller = [[InfoAppController alloc] initWithTargetCollection:collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
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
