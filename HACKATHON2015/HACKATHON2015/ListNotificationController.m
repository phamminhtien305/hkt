//
//  ListNotificationController.m
//  HACKATHON2015
//
//  Created by Tue Nguyen on 10/24/15.
//  Copyright © 2015 hackathon. All rights reserved.
//

#import "ListNotificationController.h"
#import "NotificationCell.h"
#import "NotificationObject.h"
#import "PFController.h"
#import "ReportDetailViewController.h"
#import "MainViewController.h"
#import "ReportItemObject.h"
#import <Parse/Parse.h>

@implementation ListNotificationController
- (void) getListNotificationFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"Notification"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *listObjects =[[NSMutableArray alloc] init];
        for (PFObject * object in objects) {
            [listObjects addObject:[PFController pfObjectToDict:object]];
        }

        self.items = @[[NotificationObject createListDataFromListDict:listObjects]];
        [self reloadCollectionView];
    }];
}


- (id) initWithTargetCollection:(UICollectionView *)targetCollectionView {
    if (self = [super initWithTargetCollection:targetCollectionView]) {
        [self getListNotificationFromParse];
        [self setUpEgoRefreshHeader];
    }
    return self;
}

- (void) reloadData {
    [self getListNotificationFromParse];
}


-(void)setUpEgoRefreshHeader{
    self.isLoadingRefreshHeader = NO;
    if(!self.refreshHeaderView){
        self.refreshHeaderView = [[BaseRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.targetCollectionView.bounds.size.height, [DeviceHelper getWinSize].width, self.targetCollectionView.bounds.size.height)];
        [self.refreshHeaderView setBackgroundColor:[UIColor whiteColor]];
        self.refreshHeaderView.delegate = self;
        [self.targetCollectionView addSubview:self.refreshHeaderView];
    }else{
        [self.refreshHeaderView setFrame:CGRectMake(self.refreshHeaderView.frame.origin.x,self.refreshHeaderView.frame.origin.y, [DeviceHelper getWinSize].width,self.refreshHeaderView.frame.size.height)];
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [NotificationCell getSize];
}


- (void) registerNibWithCollection:(UICollectionView*)collectionView {
    [collectionView registerNib:[NotificationCell nib] forCellWithReuseIdentifier:[NotificationCell nibName]];
}

- (NSString*) getCellIdentifierWithItem:(id) item {
    return [NotificationCell nibName];
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NotificationObject *obj = [self itemAtIndexPath:indexPath];
    [self handleSelectNotificationWithObject:obj];
}

- (void) handleSelectNotificationWithObject:(NotificationObject*) obj {
    if ([[obj objectDict][@"notification_type"] isEqualToString:@"news"]) {
        PFQuery *query = [PFQuery queryWithClassName:@"News"];
        [query getObjectInBackgroundWithId:[obj objectDict][@"notification_id"] block:^(PFObject *pfObject, NSError *error) {
            ReportItemObject *rObj = [[ReportItemObject alloc] initWithObjectDict:[PFController pfObjectToDict:pfObject]];
            ReportDetailViewController *viewController = [[ReportDetailViewController alloc] initWithReportItem:rObj];
            [[MainViewController getRootNaviController] pushViewController:viewController animated:YES];
        }];
    }
    else {
        
    }
    if (![[obj objectDict][@"is_read"] boolValue]) {
        PFQuery *query = [PFQuery queryWithClassName:@"Notification"];
        [query getObjectInBackgroundWithId:[obj objectDict][@"objectId"] block:^(PFObject *object, NSError *error) {
            object[@"is_read"] = [NSNumber numberWithBool:YES];
            [object saveInBackground];
        }];
    }
}

//- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
//    return [listItem objectAtIndex:indexPath.row];
//}

#pragma mark - Ego pull to refresh protocol
#pragma mark - Ego refresh header protocol
- (void) doneLoadingTableViewData {
    //  model should call this when its done loading
    self.isLoadingRefreshHeader = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.targetCollectionView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.refreshHeaderView) {
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.refreshHeaderView) {
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    if (self.refreshHeaderView) {
        if(!isLoading){
            [self getListNotificationFromParse];
        }
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    if (!self.refreshHeaderView) {
        return NO;
    }
    return self.isLoadingRefreshHeader; // should return if data source model is reloading
}

- (NSDate*) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    if (!self.refreshHeaderView) {
        return nil;
    }
    return [NSDate date]; // should return date data source was last changed
}

@end
