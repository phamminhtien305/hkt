//
//  TabBarView.h
//  AppComic
//
//  Created by Minh Tien on 11/23/14.
//  Copyright (c) 2014 Minh Tien. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarViewDelegate <NSObject>

-(void)tabBar:(id)sender selectTabIndex:(int)tabIndex;
-(void)doubleClick:(id)sender selectTabIndex:(int)tabIndex;
@end

@interface TabBarView : UIView
{
    UIButton *selectedBtn;
    __weak IBOutlet UIButton *btnTabbar0, *btnTabbar1, *btnTabbar2, *btnTabBar3;
    __weak IBOutlet UIImageView *imgBtnTabBar0,*imgBtnTabBar1,*imgBtnTabBar2,*imgBtnTabBar3;
    
    IBOutlet UIView *_contentView;
}
@property (nonatomic, assign) id<TabBarViewDelegate> delegate;

+ (TabBarView*) newView;
-(void)initView;
-(void)setSelectedButton:(UIButton *)button;
-(void)setSelectedTaBar:(int)index;
-(void)deselectedTabBar;
@end
