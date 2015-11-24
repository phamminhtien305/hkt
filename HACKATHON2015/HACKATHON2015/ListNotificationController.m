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
- (void) getListNotificationFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Notification"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.items = @[[NotificationObject createListDataFromPFObject:objects]];
        [self reloadCollectionView];
    }];
}


- (id) initWithTargetCollection:(UICollectionView *)targetCollectionView
{
    if (self = [super initWithTargetCollection:targetCollectionView]){
        [self getListNotificationFromParse];
    }
    return self;
}

- (void) reloadData {
    [self getListNotificationFromParse];
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [NotificationCell getSize];
}


- (void) registerNibWithCollection:(UICollectionView*)collectionView
{
    [collectionView registerNib:[NotificationCell nib]
     forCellWithReuseIdentifier:[NotificationCell nibName]];
}

- (NSString*) getCellIdentifierWithItem:(id) item
{
    return [NotificationCell nibName];
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationObject *obj = [self itemAtIndexPath:indexPath];
    [self handleSelectNotificationWithObject:obj];
}

- (void) handleSelectNotificationWithObject:(NotificationObject*) obj {
    if ([[obj pfObject][@"notification_type"] isEqualToString:@"news"]) {
        PFQuery *query = [PFQuery queryWithClassName:@"News"];
        [query getObjectInBackgroundWithId:[obj pfObject][@"notification_id"] block:^(PFObject *pfObject, NSError *error) {
            ReportItemObject *rObj = [[ReportItemObject alloc] initWithPFObject:pfObject];
            ReportDetailViewController *viewController = [[ReportDetailViewController alloc] initWithReportItem:rObj];
            [[MainViewController getRootNaviController] pushViewController:viewController animated:YES];
        }];
    }
    else {
        
    }
    if (![[obj pfObject][@"is_read"] boolValue]) {
//        [self updateReadItem:[obj pfObject].objectId];
        [obj pfObject][@"is_read"] = [NSNumber numberWithBool:YES];
        [[obj pfObject] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:READ_CHANGE_NOTIFICATION object:nil];
        }];
    }
}

- (void) updateReadItem:(NSString*) objectID{
    NotificationObject *newObject;
    NSMutableArray *newItems = [NSMutableArray array];
    for (NotificationObject *obj  in self.items[0]) {
        if ([[obj pfObject].objectId isEqualToString:objectID]) {
            PFObject *cpObject = [obj pfObject];
            cpObject[@"is_read"] = [NSNumber numberWithBool:TRUE];
            newObject = [[NotificationObject alloc] initWithPFObject:cpObject];
            [newItems addObject:cpObject];
        }
        else {
            [newItems addObject:obj];
        }
    }
    self.items = newItems;
}

-(void)refreshHeaderHandle:(id)handle{
    [self getListNotificationFromParse];
}


@end
