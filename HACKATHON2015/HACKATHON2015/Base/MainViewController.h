//
//  MainViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "BaseTabBarController.h"
#import "ReporterObject.h"

@interface MainViewController : UINavigationController
@property(nonatomic, strong) ReporterObject *reporter;
@property (nonatomic, strong) NSMutableArray *listReporterItem;
+(MainViewController *)shareMainViewController;

+(BaseNavigationController *)getRootNaviController;

-(TabBarView *)getTabBarView;

-(BaseTabBarController *)tabBarController;

@end
