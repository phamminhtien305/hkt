//
//  TabBarView.m
//  AppComic
//
//  Created by Minh Tien on 11/23/14.
//  Copyright (c) 2014 Minh Tien. All rights reserved.
//

#import "TabBarView.h"
#import "PFController.h"
@interface TabBarView()
{
    NSInteger countBadge;
}
@end

@implementation TabBarView

+ (TabBarView*) newView{
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:[[self class] nibName] bundle:[NSBundle mainBundle]];
    TabBarView *aView = (TabBarView *)viewController.view;
    [aView setFrame:CGRectMake(0, 0, [DeviceHelper getWinSize].width, 50)];
    [aView initView];
    return aView;
}

-(void)initView{
    if([DeviceHelper isDeviceIPad]){
        [_contentView setFrame:CGRectMake([DeviceHelper getWinSize].width/2  - 300, 2, 600, 50)];
    }else{
        [_contentView setFrame:CGRectMake(0, 2, [DeviceHelper getWinSize].width, 48)];
    }
    btnNotRead.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNoticeNum:) name:READ_CHANGE_NOTIFICATION object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PFController reloadReadNotice];
    });
}

- (void) updateNoticeNum:(NSNotification*) notification{
    NSInteger num = [notification.object integerValue];
    if (!notification.object) {
        countBadge --;
        num = countBadge >= 0 ? countBadge : 0;
    }
    NSLog(@"Update read num %ld %ld", (long)num, countBadge);
    countBadge = num;
    dispatch_async(dispatch_get_main_queue(), ^{
        btnNotRead.hidden = (num == 0);
        [btnNotRead setTitle:[NSString stringWithFormat:@"%ld", (long)num] forState:UIControlStateNormal];
    });
    CGRect frame = btnNotRead.frame;
    frame.origin = CGPointMake(btnTabbar1.center.x, frame.origin.y);
    btnNotRead.frame = frame;
}

+(NSString *)nibName{
    return NSStringFromClass([self class]);
}

-(IBAction)selectTabBar:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if([self.delegate respondsToSelector:@selector(tabBar:selectTabIndex:)]){
        [self.delegate tabBar:sender selectTabIndex:(int)btn.tag];
        [self setSelectedButton:btn];
    }
}

-(void)setSelectedButton:(UIButton *)button{
    switch (button.tag) {
        case 0:{
            [self deselectedButton:selectedBtn];
            [btnTabbar0 setSelected:YES];
            [imgBtnTabBar0 setImage:[UIImage imageNamed:@"icon-report-active.png"]];
            selectedBtn = btnTabbar0;
            break;
        }
        case 1:{
            [self deselectedButton:selectedBtn];
            [btnTabbar1 setSelected:YES];
            [imgBtnTabBar1 setImage:[UIImage imageNamed:@"icon-notice-active.png"]];
            selectedBtn = btnTabbar1;
            break;
        }case 2:{
            [self deselectedButton:selectedBtn];
            [btnTabbar2 setSelected:YES];
            [imgBtnTabBar2 setImage:[UIImage imageNamed:@"icon-profile-active.png"]];
            selectedBtn = btnTabbar2;
            break;
        }
        case 3:{
            [self deselectedButton:selectedBtn];
            [btnTabBar3 setSelected:YES];
            [imgBtnTabBar3 setImage:[UIImage imageNamed:@"icon-about-active.png"]];
            selectedBtn = btnTabBar3;
            break;
        }
        default:
            break;
    }
}

-(void)setSelectedTaBar:(int)index{
    switch (index) {
        case 0:
            [self setSelectedButton:btnTabbar0];
            break;
        case 1:
            [self setSelectedButton:btnTabbar1];
            break;
        case 2:
            [self setSelectedButton:btnTabbar2];
            break;
        case 3:
            [self setSelectedButton:btnTabBar3];
            break;
        default:
            break;
    }
}

-(void)deselectedButton:(UIButton *)button{
    switch (button.tag) {
        case 0:
            [imgBtnTabBar0 setImage:[UIImage imageNamed:@"icon-report.png"]];
            [btnTabbar0 setSelected:NO];
            break;
        case 1:
            [imgBtnTabBar1 setImage:[UIImage imageNamed:@"icon-notice.png"]];
            [btnTabbar1 setSelected:NO];
            break;
        case 2:
            [imgBtnTabBar2 setImage:[UIImage imageNamed:@"icon-profile.png"]];
            [btnTabbar2 setSelected:NO];
            break;
        case 3:
            [imgBtnTabBar3 setImage:[UIImage imageNamed:@"icon-about.png"]];
            [btnTabBar3 setSelected:NO];
            break;
        default:
            break;
    }
   
}
-(void)deselectedTabBar{
    [self deselectedButton:selectedBtn];
}

-(IBAction)doubleClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if([self.delegate respondsToSelector:@selector(doubleClick:selectTabIndex:)]){
        [self.delegate doubleClick:nil selectTabIndex:(int)btn.tag];
    }
}



@end
