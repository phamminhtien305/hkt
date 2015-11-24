//
//  ListReportController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ListReportController.h"
#import "ReportItemCell.h"
#import "APIEngineer+Report.h"
#import "AddNewReportCell.h"

#import "AddReportViewController.h"
#import "ReportDetailViewController.h"
#import "NotificationController.h"

@implementation ListReportController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView
                 withListType:(LIST_REPORT_TYPE)type
{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self)
    {
        listItem = [[NSMutableArray  alloc] init];
        listSection = [[NSMutableArray alloc] initWithObjects:listItem, nil];
        if(type == USER_REPORT){
            [self getListUserReport];
        }else if(type == USER_FOLLOW_REPORT){
            
        }else if(type == USER_REQUEST){
            
        }
    }
    return self;
}


-(void)getListUserReport{
    [[APIEngineer sharedInstance] getUsersReportItemContentOnComplete:^(id result, BOOL isCache)
    {
        if(result && [result isKindOfClass:[NSArray class]])
        {
            [listItem removeAllObjects];
            [listItem addObjectsFromArray:[ReportItemObject createListDataFromPFObject:result]];
            [self reloadCollectionView];
        }
    } onError:^(NSError *error) {
        
    }];
}

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView
                 withListItem:(NSMutableArray *)items
{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listItem = [[NSMutableArray  alloc] initWithArray:items];
        listSection = [[NSMutableArray alloc] initWithObjects:listItem, nil];
        [self updateCollectionViewWithListItem:listSection];
        if([listItem count] == 0)
        {
            [self getListReportFromParse];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getListReportFromParse)
                                                     name:STATE_CHANGE_NOTIFICATION
                                                   object:nil];
    }
    return self;
}


-(void)refreshHeaderHandle:(id)handle{
    [self getListReportFromParse];
}

-(void)getListReportFromParse
{
    [[APIEngineer sharedInstance] getReportsItemContentOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [listItem removeAllObjects];
            [listItem addObject:@"Bạn muốn báo cáo gì?"];
            [listItem addObjectsFromArray:[ReportItemObject createListDataFromPFObject:result]];
            [self reloadCollectionView];
        }

    } onError:^(NSError *error) {}];
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:BACKGROUND_COLLECTION];
    [collectionView registerNib:[ReportItemCell nib] forCellWithReuseIdentifier:[ReportItemCell nibName]];
    [collectionView registerNib:[AddNewReportCell nib] forCellWithReuseIdentifier:[AddNewReportCell nibName]];
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    if([item isKindOfClass:[NSString class]]){
        return [AddNewReportCell nibName];
    }
    return [ReportItemCell nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    if([item isKindOfClass:[NSString class]]){
        return [AddNewReportCell getSize];
    }
    return [ReportItemCell getSize];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    if([item isKindOfClass:[NSString class]]){
        AddReportViewController *reportView = [[AddReportViewController alloc] initUsingNib];
        [[MainViewController getRootNaviController] pushViewController:reportView animated:YES];
    }else{
        ReportDetailViewController *reportDetailView = [[ReportDetailViewController alloc] initWithReportItem:item];
        [[MainViewController getRootNaviController] pushViewController:reportDetailView animated:YES];
    }
}



@end
