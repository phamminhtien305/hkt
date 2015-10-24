//
//  NavigationbarView.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "NavigationbarView.h"

@implementation NavigationbarView

+(NavigationbarView *)newView{
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"NavigationbarView" bundle:[NSBundle mainBundle]];
    NavigationbarView *aView = (NavigationbarView *)viewController.view;
    [aView setBackgroundColor:BACKGROUND_NAVIGATIONBAR];
    [aView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 65)];
    return aView;
}


-(void)updateTitle:(NSString *)title{
    [lbTitle  setText:title];
}


-(IBAction)clickBack:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(backHandle:)]){
        [self.delegate backHandle:sender];
    }
}


-(IBAction)clickAdd:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addReportHandle:)]){
        [self.delegate addReportHandle:sender];
    }
}

@end
