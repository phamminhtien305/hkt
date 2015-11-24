//
//  NewsCell.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "NotificationObject.h"
@interface NotificationCell : BaseCollectionViewCell
{
    NotificationObject *item;

    __weak IBOutlet UILabel *lbTitle;
    __weak IBOutlet UILabel *createDate;
    __weak IBOutlet UIImageView *thumbnail;
    
}
@end
