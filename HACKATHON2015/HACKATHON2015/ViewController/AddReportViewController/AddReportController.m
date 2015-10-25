//
//  AddReportController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "AddReportController.h"
#import "ReportCell.h"
#import "HeaderAddReportView.h"
#import "APIEngineer+Report.h"
#import "ReportObject.h"
#import "ReportInfoViewController.h"
@implementation AddReportController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listItem = [[NSMutableArray alloc] init];
        listSection = [[NSMutableArray alloc] init];
        [self getReportTypeFromServer];
    }
    return self;
}

-(void)getReportTypeFromServer{
    [[APIEngineer sharedInstance] getReportContentOnComplete:^(id result, BOOL isCache) {
        NSArray *list = [ReportObject createListDataFromPFObject:result];
        [listSection addObjectsFromArray:list];
        [self updateCollectionViewWithListItem:listSection];
    } onError:^(NSError *error) {
        
    }];
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [listSection objectAtIndex:indexPath.section];
    if(item && [item isKindOfClass:[ReportObject class]]){
        ReportObject *reportType = (ReportObject*)item;
        NSArray *listItemOfReport = [reportType getListReport];
        return [listItemOfReport objectAtIndex:indexPath.row];
    }else{
        return nil;
    }
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerNib:[ReportCell nib] forCellWithReuseIdentifier:[ReportCell nibName]];
    [collectionView registerNib:[HeaderAddReportView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderAddReportView nibName]];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    id item = [listSection objectAtIndex:section];
    if(item && [item getListReport]){
        return [[item getListReport] count];
    }
    return 0;
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    return [ReportCell nibName];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReportCell *cell = (ReportCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    id item = [listSection objectAtIndex:indexPath.section];
    if(item && [item isKindOfClass:[ReportObject class]]){
        ReportObject *reportType = (ReportObject*)item;
        NSArray *listItemOfReport = [reportType getListReport];
        NSString *itemAtIndexPath = [self itemAtIndexPath:indexPath];
        if([itemAtIndexPath isEqualToString:[listItemOfReport lastObject]]){
            cell.isLastCell = YES;
        }else{
            cell.isLastCell = NO;
        }
    }else{
        cell.isLastCell = NO;
    }
    [cell updateCell];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [ReportCell getSize];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [HeaderAddReportView getSize];
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        id item = [listSection objectAtIndex:indexPath.section];
        HeaderAddReportView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderAddReportView nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        [collectionHeader configHeader:item];
    }
    return reusableView;
}





-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *item = [self itemAtIndexPath:indexPath];
    if(item){
        ReportInfoViewController *reportView = [[ReportInfoViewController alloc] initWithTitleName:item];
        [[MainViewController getRootNaviController] pushViewController:reportView animated:YES];
    }
}







@end
