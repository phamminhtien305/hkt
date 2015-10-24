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
    [lbwarning setHidden:YES];
    txtEmail.delegate = self;
    txtFirstName.delegate = self;
    txtLastName.delegate = self;
    txtPhone.delegate = self;
    if([MainViewController shareMainViewController].reporter){
        [self updateViewWithReporterObject:[MainViewController shareMainViewController].reporter];
    }
}

+(CGSize)getSize{
    return CGSizeMake([DeviceHelper getWinSize].width, 250);
}

-(void)configHeader:(id)data{
    if([MainViewController shareMainViewController].reporter){
        [self updateViewWithReporterObject:[MainViewController shareMainViewController].reporter];
    }
}

-(IBAction)clickSubmitReporter:(id)sender{
    if([txtPhone.text length]  == 0 || [txtEmail.text length] == 0 || [txtFirstName.text length] == 0 || [txtLastName.text length] == 0){
        [lbwarning setHidden:NO];
    }else{
        [lbwarning setHidden:YES];
        
        PFUser *user = [[PFUser alloc] init];
        
        user[@"user_first_name"] = txtFirstName.text;
        user[@"user_last_name"] = txtLastName.text;
        user[@"user_phone"] = txtPhone.text;
        user[@"email"] = txtEmail.text;

        NSDictionary *reporterDic  = [[NSDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtFirstName.text,@"first_name",txtLastName.text,@"last_name",txtPhone.text,@"phone", nil];
        ReporterObject *reporter = [[ReporterObject alloc] initWithObjectDict:reporterDic];
        
        [MainViewController shareMainViewController].reporter = reporter;
        
        NSString *data = AFJSONStringFromParameters(reporterDic);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"current_reporter"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                NSDictionary *reporterDic  = [[NSDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtFirstName.text,@"first_name",txtLastName.text,@"last_name",txtPhone.text,@"phone", nil];
                ReporterObject *reporter = [[ReporterObject alloc] initWithObjectDict:reporterDic];
                NSString *data = AFJSONStringFromParameters(reporterDic);
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"current_reporter"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [MainViewController shareMainViewController].reporter = reporter;
            }else{
                
            }
        }];

    }
}


-(void)updateViewWithReporterObject:(ReporterObject *)reporter{
    [txtEmail setText:[reporter getReporterEmail]];
    [txtFirstName setText:[reporter getReporterFirstName]];
    [txtLastName setText:[reporter getReporterLastName]];
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
    
}

- (BOOL) textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Check the replacementString
    return YES;
}




@end
