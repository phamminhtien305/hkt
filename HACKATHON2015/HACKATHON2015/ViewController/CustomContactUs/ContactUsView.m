//
//  ContactUsView.m
//  HACKATHON2015
//
//  Created by Minh Tien on 3/17/16.
//  Copyright © 2016 hackathon. All rights reserved.
//

#import "ContactUsView.h"

@implementation ContactUsView

+(ContactUsView *)showContactUsView{
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"ContactUsView" bundle:[NSBundle mainBundle]];
    ContactUsView *contactView = (ContactUsView *)viewController.view;
    
    [contactView showWithAnimation:YES];
    return contactView;
}

-(void)showWithAnimation:(BOOL)animation{
    txtContent.delegate = self;
    txtObject.delegate = self;
    [self setAlpha:0.0];
    [self setFrame:CGRectMake(0, 0, [DeviceHelper getWinSize].width, [DeviceHelper getWinSize].height)];
    [[[AppDelegate shareInstance] window] addSubview:self];
    
    [UIView animateWithDuration:.5 animations:^{
        [self setAlpha:1.0];
    }];

}

-(IBAction)send:(id)sender{
    if(sending) return;
    sending = YES;
    [txtObject endEditing:YES];
    [txtContent endEditing:YES];
    if([txtContent.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Vui lòng nhập nội dung thư phản hồi!" delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
        [alert show];
        sending = NO;
        return;
    }
    if([txtObject.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Vui lòng nhập tiêu đề thư phản hồi!" delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
        [alert show];
        sending = NO;
        return;
    }

    PFObject *object = [PFObject objectWithClassName:@"Contact"];
    object[@"content"] = txtContent.text;
    object[@"title"] = txtObject.text;
    object[@"user"] =  [PFUser currentUser];
    object[@"to"] =  @"People Service - iOS version";
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Phản hồi của bạn đã được gửi đi." delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
            alert.delegate =self;
            alert.tag = 69;
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Lỗi! Vui lòng thử lại sau." delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
            [alert show];
        }
        sending = NO;
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 69){
        [self dismissView];
    }
}

-(IBAction)dismiss:(id)sender{
    [self dismissView];
}

-(void)dismissView{
    [UIView animateWithDuration:.5 animations:^{
        [self setAlpha:1.0];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}




@end
