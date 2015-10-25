//
//  MainViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "MainViewController.h"
#import "BaseTabBarController.h"
#import "ListReportViewController.h"
#import "NotifiViewController.h"
#import "ProfileViewController.h"
#import "InfoViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController


+(MainViewController *)shareMainViewController{
    static MainViewController *mainViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ListReportViewController *listReport = [[ListReportViewController alloc] initUsingNib];
        BaseNavigationController *navigationReport = [[BaseNavigationController alloc] initWithRootViewController:listReport];
        
        NotifiViewController *notification = [[NotifiViewController alloc] initUsingNib];
        BaseNavigationController *navigationNotifi = [[BaseNavigationController alloc] initWithRootViewController:notification];
        
        ProfileViewController *profile = [[ProfileViewController alloc] initUsingNib];
        BaseNavigationController *navigationProfile = [[BaseNavigationController  alloc] initWithRootViewController:profile];
        
        InfoViewController *infoViewController =[[InfoViewController alloc] initUsingNib];
        BaseNavigationController *navigationInfo = [[BaseNavigationController alloc] initWithRootViewController:infoViewController];
        
        
        BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
        tabBar.viewControllers = [[NSArray alloc] initWithObjects:navigationReport,navigationNotifi,navigationProfile,navigationInfo, nil];
        
        mainViewController = [[MainViewController alloc] initWithRootViewController:tabBar];

        [mainViewController setNavigationBarHidden:YES];
    });
    return mainViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString *reporter =[[NSUserDefaults standardUserDefaults] objectForKey:@"current_reporter"];
//    if(reporter){
//        NSDictionary *reporterDic = [reporter objectFromJSONString];
//        self.reporter = [[ReporterObject alloc] initWithObjectDict:reporterDic];
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(BaseNavigationController *)getRootNaviController{
    id rootNavi =  [[((BaseTabBarController *)[MainViewController shareMainViewController].viewControllers[0]) viewControllers] objectAtIndex:[((BaseTabBarController *)[MainViewController shareMainViewController].viewControllers[0]) selectedIndex]];
    if(rootNavi && [rootNavi isKindOfClass:[BaseNavigationController class]]){
        return rootNavi;
    }
    return nil;
}



-(TabBarView *)getTabBarView{
    BaseTabBarController  * tabBar = (BaseTabBarController *)[[MainViewController shareMainViewController] topViewController];
    return tabBar.tabBarView;
}

-(BaseTabBarController *)tabBarController{
    return (BaseTabBarController *)[[MainViewController shareMainViewController] topViewController];
}


@end
