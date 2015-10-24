//
//  ListReportViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"
#import "BasePageViewController.h"
#import "SegmentView.h"
@interface ListReportViewController : BaseViewController<PageViewControllerDelegate,SegmentDelegate>
{
    BasePageViewController *pageViewController;
    IBOutlet SegmentView *segmentView;
    IBOutlet UICollectionView *collectionView;
    NSMutableArray *listItem;
    NSArray* listPage;
}
@end
