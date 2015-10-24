//
//  SegmentCellListAlbum.h
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface SegmentCell : BaseCollectionViewCell
{
    __weak IBOutlet UILabel *lbtilte;
    __weak IBOutlet UIView *selectedView;
}

-(void)configCell:(NSString *)title withSelected:(BOOL)selected;
@end
