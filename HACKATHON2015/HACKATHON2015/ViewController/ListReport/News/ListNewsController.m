//
//  ListNewsController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ListNewsController.h"
#import "APIEngineer+Report.h"
#import "HeaderNewsView.h"
#import "NewsCell.h"
#import "ReportDetailViewController.h"

@implementation ListNewsController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView
                 withListItem:(NSMutableArray *)items
{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listItem = [[NSMutableArray  alloc] initWithArray:items];
        listSection = [[NSMutableArray alloc] initWithObjects:listItem, nil];
        [self updateCollectionViewWithListItem:listSection];
        if([listItem count] == 0){
            [self getListNewsFromParse];
        }
    }
    return self;
}

-(void)refreshHeaderHandle:(id)handle{
    [self getListNewsFromParse];
}

-(void)getListNewsFromParse
{
    [[APIEngineer sharedInstance] getNewsItemContentOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]])
        {
            [listItem removeAllObjects];
            [listItem addObjectsFromArray:[NewsObject createListDataFromPFObject:result]];
            [self reloadCollectionView];
        }
    } onError:^(NSError *error) {
        
    }];
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView
{
    [collectionView setBackgroundColor:BACKGROUND_COLLECTION];
    [collectionView registerNib:[NewsCell nib] forCellWithReuseIdentifier:[NewsCell nibName]];
    [collectionView registerNib:[HeaderNewsView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderNewsView nibName]];
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    return [NewsCell nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [NewsCell getSize];
}

-(CGSize)collectionView:(UICollectionView*)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return [HeaderNewsView  getSize];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        HeaderNewsView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderNewsView nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        if([listItem count] > 3)
        {
            NSArray *arr = [[NSArray alloc] initWithObjects:listItem[0],listItem[1],listItem[2], nil];
            [collectionHeader configHeader:arr];
        }
    }
    return reusableView;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    if([item isKindOfClass:[NewsObject class]])
    {
        ReportDetailViewController *reportDetailView = [[ReportDetailViewController alloc] initWithReportItem:item];
        [[MainViewController getRootNaviController] pushViewController:reportDetailView animated:YES];
    }
}


@end
