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
    if([MainViewController shareMainViewController].reporter){
        [self updateViewWithReporterObject:[MainViewController shareMainViewController].reporter];
    }
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 240);
}

-(void)configHeader:(id)data{
    if([MainViewController shareMainViewController].reporter){
        [self updateViewWithReporterObject:[MainViewController shareMainViewController].reporter];
    }
}

-(IBAction)clickSubmitReporter:(id)sender{
    
}


-(void)updateViewWithReporterObject:(ReporterObject *)reporter{
    [txtEmail setText:[reporter getReporterEmail]];
    [txtFirstName setText:[reporter getReporterFirstName]];
    [txtPhone setText:[reporter getReporterPhone]];
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
    user[@"user_phone"] = txtPhone.text;
    user[@"email"] = txtEmail.text;
    
    
    NSDictionary *reporterDic  = [[NSDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtFirstName.text,@"first_name",@"",@"last_name",txtPhone.text,@"phone", nil];
    
    NSString *data = AFJSONStringFromParameters(reporterDic);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"current_reporter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //
    //        ReporterObject *reporter = [[ReporterObject alloc] initWithObjectDict:reporterDic];
    //
    //        [MainViewController shareMainViewController].reporter = reporter;
    //
    //        NSString *data = AFJSONStringFromParameters(reporterDic);
    //        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"current_reporter"];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //
    //        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    //            if(succeeded){
    //                NSDictionary *reporterDic  = [[NSDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtFirstName.text,@"first_name", @"", @"last_name",txtPhone.text,@"phone", nil];
    //                ReporterObject *reporter = [[ReporterObject alloc] initWithObjectDict:reporterDic];
    //                NSString *data = AFJSONStringFromParameters(reporterDic);
    //                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"current_reporter"];
    //                [[NSUserDefaults standardUserDefaults] synchronize];
    //                [MainViewController shareMainViewController].reporter = reporter;
    //            }else{
    //
    //            }
    //        }];
    
}



@end
