//
//  BaseNavigationController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationbarView.h"
@interface BaseNavigationController : UINavigationController<NavigationbarViewDelegate>
{
    NavigationbarView *navigationBar;
    
}

-(void)updateTitle:(NSString *)title;

-(NavigationbarView *)getNavigationBarView;

-(void)hiddenNavigationButtonLeft:(BOOL)hidden;

-(void)hiddenNavigationButtonRight:(BOOL)hidden;

@end
