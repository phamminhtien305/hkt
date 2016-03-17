//
//  ContactUsView.h
//  HACKATHON2015
//
//  Created by Minh Tien on 3/17/16.
//  Copyright © 2016 hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsView : UIView<UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UITextField *txtObject;
    __weak IBOutlet UITextView * txtContent;
    BOOL sending;
}
+(ContactUsView *)showContactUsView;
@end
