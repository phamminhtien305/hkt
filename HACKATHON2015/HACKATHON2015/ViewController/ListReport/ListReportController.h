//
//  ListReportController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionController.h"
#import "BaseRefreshTableHeaderView.h"

@interface ListReportController : BaseCollectionController<EGORefreshTableHeaderDelegate>
{
    NSMutableArray *listItem;
    NSMutableArray *listSection;
    BOOL _isReport;
    BOOL isLoading;
}


@property (readwrite) BOOL isLoadingRefreshHeader;
@property (nonatomic, retain) BaseRefreshTableHeaderView * refreshHeaderView;

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView withListItem:(NSMutableArray *)item forListReport:(BOOL)isReport;

-(void)getListReportFromParse;
@end
