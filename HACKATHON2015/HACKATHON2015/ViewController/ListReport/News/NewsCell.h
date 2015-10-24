//
//  NewsCell.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "NewsObject.h"
@interface NewsCell : BaseCollectionViewCell
{
    NewsObject *item;
    
    __weak IBOutlet UILabel *lbTitle;
    __weak IBOutlet UILabel *lbDescription;
    __weak IBOutlet UILabel *createDate;
    __weak IBOutlet UILabel *lbReporter;
    __weak IBOutlet UIImageView *thumbnail;
    
}
@end
