//
//  CellProfile.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/29/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface CellProfile : BaseCollectionViewCell
{
    __weak IBOutlet UILabel *lbTitle;
    __weak IBOutlet UIImageView *thumbNail;
    
}

@end
