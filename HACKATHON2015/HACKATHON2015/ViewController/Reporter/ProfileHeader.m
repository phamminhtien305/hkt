//
//  ProfileHeader.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ProfileHeader.h"
#import <Parse/Parse.h>

@implementation ProfileHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    txtEmail.delegate = self;
    txtFirstName.delegate = self;
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 168);
}

-(void)configHeader:(id)data{
    [self updateViewWithReporterObject:[PFUser currentUser]];
}

-(IBAction)clickSubmitReporter:(id)sender{
    
}


-(void)updateViewWithReporterObject:(PFUser*) user{
    if(user[@"email"] && user[@"user_full_name"]){
        NSString *name = user[@"user_full_name"];
        [lbEmail setText:user[@"email"]];
        [lbName setText:user[@"user_full_name"]];
        [UIView animateWithDuration:0.25 animations:^{
            [viewLogin setAlpha:0.0];
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                [viewInfo setAlpha:1.0];
            }];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [viewInfo setAlpha:0.0];
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                [viewLogin setAlpha:1.0];
            }];
        }];
    }

}

#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 2 && [textField.text length] > 0){
        if(txtFirstName.text && [txtFirstName.text length] > 0){
            [self updateUser];
        }
    }
}

- (BOOL) textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Check the replacementString
    return YES;
}


-(void)updateUser{
        
    PFUser *user = [PFUser currentUser];
    
    user[@"user_full_name"] = txtFirstName.text;
    user[@"email"] = txtEmail.text;
    
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [NotificationManager postNotificationWhenUpdatedUserInfoWithObject:nil];
    }];
}



@end
