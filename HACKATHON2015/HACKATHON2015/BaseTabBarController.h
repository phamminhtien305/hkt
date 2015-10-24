//
//  BaseTabBarController.h
//  MTLab
//
//  Created by Minh Tien on 5/30/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#define animation_time_delay 3
#define TabBarViewOn 1


@interface BaseTabBarController : UITabBarController<UITextFieldDelegate, TabBarViewDelegate>{
    BOOL tabBarIsShowMore;
    
}

@property (nonatomic, strong) TabBarView *tabBarView;

-(void)creatTabBar;

-(void)setSelectTabBarWithIndex:(int)tabIndex;

-(void)showHiddenTabBarWithOffset:(float)index withScrollView:(UIScrollView *)scrollView;

-(void)setPositionTabBarWithAnimation:(BOOL)animation;

-(void)hiddenCustomTabBarWithAnimation;

-(void)hiddenCustomTabBar;

-(void)uncheckAllTab;


@end
