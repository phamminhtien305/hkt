//
//  ProfileController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ProfileController.h"
#import "ProfileHeader.h"

#import "ReportItemCell.h"
#import "HeaderAddReportView.h"

#import "APIEngineer+Report.h"

@implementation ProfileController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listSection = [[NSMutableArray alloc] init];
        NSArray *list = [[NSArray alloc] init];
        [listSection addObject:list];
        [self updateCollectionViewWithListItem:listSection];
        [self getListUserReport];
    }
    return self;
}

-(void)getListUserReport{
    [[APIEngineer sharedInstance] getUsersReportItemContentOnComplete:^(id result, BOOL isCache) {
        [listSection removeAllObjects];
        NSArray *list = [[NSArray alloc] init];
        [listSection addObject:list];
        listMyReport =[[ReportItemObject createListDataFromPFObject:result] mutableCopy];
        [listSection addObject:listMyReport];
        [self updateCollectionViewWithListItem:listSection];
    } onError:^(NSError *error) {
        
    }];
}

-(void)getListUserLike{
    
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerNib:[ReportItemCell nib] forCellWithReuseIdentifier:[ReportItemCell nibName]];
    [collectionView registerNib:[ProfileHeader nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ProfileHeader nibName]];
    [collectionView registerNib:[HeaderAddReportView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderAddReportView nibName]];
    
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    return [ReportItemCell nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [ReportItemCell getSize];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return [ProfileHeader getSize];
    }
    return [HeaderAddReportView getSize];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if(indexPath.section == 0){
            ProfileHeader *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ProfileHeader nibName] forIndexPath:indexPath];
            reusableView = collectionHeader;
            [collectionHeader configHeader:nil];
        }else{
            NSString *headerTitle = @"";
            if(indexPath.section == 1){
                headerTitle = @"Tin đã đăng";
            }else if(indexPath.section == 2){
                headerTitle = @"Tin đã lưu";
            }
            HeaderAddReportView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderAddReportView nibName] forIndexPath:indexPath];
            reusableView = collectionHeader;
            [collectionHeader configHeader:headerTitle];
        }
    }
    return reusableView;
}




@end
