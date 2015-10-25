//
//  InfoCell.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface InfoCell : BaseCollectionViewCell
{
    __weak IBOutlet UILabel *lbTitle;
    __weak IBOutlet UILabel *lbValue;
    NSDictionary *objectDic;
}
@end
