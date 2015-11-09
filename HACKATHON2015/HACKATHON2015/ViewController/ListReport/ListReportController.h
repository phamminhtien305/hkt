//
//  ListReportController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionController.h"
#import "BaseRefreshTableHeaderView.h"

@interface ListReportController : BaseCollectionController
{
    NSMutableArray *listItem;
    NSMutableArray *listSection;
}

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView
                 withListItem:(NSMutableArray *)items;

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView
                 withListType:(LIST_REPORT_TYPE)type;
@end
