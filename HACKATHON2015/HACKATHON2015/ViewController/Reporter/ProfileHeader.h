//
//  ProfileHeader.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@interface ProfileHeader : BaseCollectionReusableView<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txtFirstName, *txtEmail;
    
    __weak IBOutlet UIView *viewLogin, *viewInfo;
    
    __weak IBOutlet UILabel *lbName, *lbEmail;
}
@end
