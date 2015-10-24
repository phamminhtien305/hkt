//
//  ListNotificationController.h
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "BaseCollectionController.h"
#import "BaseRefreshTableHeaderView.h"

@interface ListNotificationController : BaseCollectionController <EGORefreshTableHeaderDelegate>
{
    BOOL isLoading;
}
@property (readwrite) BOOL isLoadingRefreshHeader;
@property (nonatomic, retain) BaseRefreshTableHeaderView * refreshHeaderView;
- (void) reloadData;
@end
