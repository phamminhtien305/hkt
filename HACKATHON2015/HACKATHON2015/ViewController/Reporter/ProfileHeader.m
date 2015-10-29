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
    txtPhone.delegate = self;
    [self updateViewWithReporterObject:[PFUser currentUser]];
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 240);
}

-(void)configHeader:(id)data{
    [self updateViewWithReporterObject:[PFUser currentUser]];
}

-(IBAction)clickSubmitReporter:(id)sender{
    
}


-(void)updateViewWithReporterObject:(PFUser*) user{
    [txtEmail setText:user[@"email"]];
    [txtFirstName setText:user[@"user_full_name"]];
    [txtPhone setText:user[@"phone"]];
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
    
    
    [[PFUser currentUser] saveInBackground];
    
   }



@end
