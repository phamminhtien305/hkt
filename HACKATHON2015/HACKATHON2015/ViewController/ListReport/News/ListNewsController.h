//
//  ListNewsController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionController.h"
#import "BaseRefreshTableHeaderView.h"

@interface ListNewsController : BaseCollectionController<EGORefreshTableHeaderDelegate>{
    NSMutableArray *listItem;
    NSMutableArray *listSection;
    BOOL isLoading;
}

@property (readwrite) BOOL isLoadingRefreshHeader;
@property (nonatomic, retain) BaseRefreshTableHeaderView * refreshHeaderView;

- (id) initWithTargetCollection:(UICollectionView *)targetCollectionView withListItem:(NSMutableArray *)items;
-(void)getListNewsFromParse;
@end