//
//  ListFavoriteViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"
#import "ListReportController.h"

@interface PageListReportViewController : BaseViewController
{
    ListReportController *controller;
    __weak IBOutlet UICollectionView *collectionView;
    LIST_REPORT_TYPE type;
    NSString *title;
}

-(id)initWithListUserReport;
-(id)initWithListUserRequest;
-(id)initWithListUserFollow;
@end
