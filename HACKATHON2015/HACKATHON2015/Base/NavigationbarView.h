//
//  NavigationbarView.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationbarViewDelegate <NSObject>
@optional
-(void)backHandle:(id)sender;
-(void)addReportHandle:(id)sender;

@end
@interface NavigationbarView : UIView
{
    IBOutlet UILabel *lbTitle;

}
@property (nonatomic, strong) IBOutlet UIButton *btnLeft;
@property (nonatomic, strong) IBOutlet UIButton *btnRight;
@property (nonatomic, strong) id<NavigationbarViewDelegate>delegate;
+(NavigationbarView *)newView;

-(void)updateTitle:(NSString *)title;

@end
