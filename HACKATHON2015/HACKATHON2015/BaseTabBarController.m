//
//  BaseTabBarController.m
//  MTLab
//
//  Created by Minh Tien on 5/30/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ListReportViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addTabBar];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



-(void)addTabBar{
    [self hiddenStandarTabBarWithAnimation:NO];
    [self creatTabBar];
    [self setPositionTabBarWithAnimation:NO];
}



// Keyboard portrait height:
// Detect iOS 8: 253
// Less than iOS 8: 216
// Keyboard landscape
// Detect iOS 8: 193
// Less than iOS 8: 162
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
}

#pragma mark - TabBarView Delegate
-(void)tabBar:(id)sender selectTabIndex:(int)tabIndex{
    [self setSelectTabBarWithIndex:tabIndex];
}

-(void)setSelectTabBarWithIndex:(int)tabIndex{
    self.selectedIndex = tabIndex;
    if(tabIndex == 4){
        if(tabBarIsShowMore){
            [self showTabBarStateNormal];
        }else{
            [self showTabBarStateMore];
        }
    }
}

-(void)showTabBarStateMore{
    
}

-(void)showTabBarStateNormal{
    [UIView animateWithDuration:0.25 animations:^{
        [_tabBarView setFrame:CGRectMake(0, [DeviceHelper getWinSize].height - TABBAR_HEIGHT, [DeviceHelper getWinSize].width, _tabBarView.frame.size.height)];
    }completion:^(BOOL finished) {
        tabBarIsShowMore = NO;
    }];
}


-(void)doubleClick:(id)sender selectTabIndex:(int)tabIndex{

}

-(void)creatTabBar{
    if(!_tabBarView){
        _tabBarView = [TabBarView newView];
        _tabBarView.delegate  = self;
        
        [_tabBarView setFrame:CGRectMake(0, [DeviceHelper getWinSize].height, [DeviceHelper getWinSize].width, 200 + TABBAR_HEIGHT)];
        [self.view addSubview:_tabBarView];
        [self.view bringSubviewToFront:_tabBarView];
        [_tabBarView setSelectedTaBar:(int)self.selectedIndex];
    }
    
}

-(void)setPositionTabBarWithAnimation:(BOOL)animation{
    if(!_tabBarView){
        [self creatTabBar];
    }
    float duration = 0;
    if(animation)
        duration = 0.25;
    [UIView animateWithDuration:duration animations:^{
        if(DETECT_OS7){
            [_tabBarView setFrame:CGRectMake(0, [DeviceHelper getWinSize].height - TABBAR_HEIGHT, [DeviceHelper getWinSize].width, 200 + TABBAR_HEIGHT)];
        }else{
            [_tabBarView setFrame:CGRectMake(0, [DeviceHelper getWinSize].height - TABBAR_HEIGHT - 20, [DeviceHelper getWinSize].width, 200 + TABBAR_HEIGHT)];
        }
    }];
}

-(void)hiddenCustomTabBarWithAnimation{
    if(TabBarViewOn == 1){
        if(_tabBarView){
            [UIView animateWithDuration:0.25 animations:^{
                [_tabBarView setFrame:CGRectMake(0, [DeviceHelper getWinSize].height, [DeviceHelper getWinSize].width, 200 + TABBAR_HEIGHT)];
            }completion:^(BOOL finished) {
                [self hiddenCustomTabBar];
            }];
        }
    }
}


-(void)showStandarTabBarWithAnimation:(BOOL)animation{
    UITabBar *tabBar = self.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    parent.clipsToBounds = YES;
    float duration = 0;
    if(animation)
        duration = 0.25;
    [UIView animateWithDuration:duration
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = 10000;//CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}

-(void)hiddenCustomTabBar{
    if(_tabBarView && [_tabBarView respondsToSelector:@selector(removeFromSuperview)])
    {
        [_tabBarView setHidden:YES];
        [_tabBarView removeFromSuperview];
        _tabBarView = nil;
        
    }
}

-(void)hiddenStandarTabBarWithAnimation:(BOOL)animation{
    UITabBar *tabBar = self.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    parent.clipsToBounds = YES;
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    float duration = 0;
    if(animation){
        duration = 0.25;
    }
    [UIView animateWithDuration:duration
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = 1000;// CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                         ((UIView *)[parent.subviews objectAtIndex:0]).frame = [DeviceHelper getWinFrame];
                     }];
}

-(void)showHiddenTabBarWithOffset:(float)index withScrollView:(UIScrollView *)scrollView{
    if(TabBarViewOn == 1){
        if(index >0){ // Show tabBar
            if(_tabBarView && _tabBarView.frame.origin.y > [DeviceHelper getWinSize].height - TABBAR_HEIGHT + index){
                int position = _tabBarView.frame.origin.y;
                position -=index ;
                [self animationForTabBar:position];
            }else{
                [self setPositionTabBarWithAnimation:NO];
            }
            if(!_tabBarView){
                [self creatTabBar];
            }
            if(scrollView.contentOffset.y < scrollView.frame.size.height/2){
                [self setPositionTabBarWithAnimation:NO];
            }
        }else{ // Hidden tabBar
            if(_tabBarView && _tabBarView.frame.origin.y < [DeviceHelper getWinSize].height){
                int position =  _tabBarView.frame.origin.y;
                position -=index;
                [self animationForTabBar:position];
            }
            
            if(_tabBarView && scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - TABBAR_HEIGHT){
                [self hiddenCustomTabBar];
            }
            if(_tabBarView && _tabBarView.frame.origin.y >= [DeviceHelper getWinSize].height){
                [self hiddenCustomTabBar];
            }
        }
    }
}

-(void)animationForTabBar:(float)position{
    [UIView animateWithDuration:0.05 animations:^{
        [_tabBarView setFrame:CGRectMake(0, position, _tabBarView.frame.size.width, _tabBarView.frame.size.height)];
    }];
}


-(void)uncheckAllTab{
    [_tabBarView deselectedTabBar];
}



@end
