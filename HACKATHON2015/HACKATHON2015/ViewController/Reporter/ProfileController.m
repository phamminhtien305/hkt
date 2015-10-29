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
#import "CellProfile.h"

#import "PageListReportViewController.h"

@implementation ProfileController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listSection = [[NSMutableArray alloc] init];
        
        NSDictionary *item1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tin đã đăng",@"title",@"tindadang.png",@"thumb", nil];
        NSDictionary *item2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tin đã lưu",@"title",@"tindaluu.png",@"thumb", nil];
        NSDictionary *item3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tin cần xử lý",@"title",@"Request.png",@"thumb", nil];
        
        NSArray *list = [[NSArray alloc] initWithObjects:item1,item2,item3, nil];
        
        [listSection addObject:list];
        [self updateCollectionViewWithListItem:listSection];
    }
    return self;
}


-(void)getListUserLike{
    
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerNib:[ProfileHeader nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ProfileHeader nibName]];
    [collectionView registerNib:[CellProfile nib] forCellWithReuseIdentifier:[CellProfile nibName]];
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    return [CellProfile nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [CellProfile getSize];
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
        ProfileHeader *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ProfileHeader nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        [collectionHeader configHeader:nil];
    }
    return reusableView;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        PageListReportViewController *page = [[PageListReportViewController alloc] initWithListUserReport];
        [[MainViewController getRootNaviController] pushViewController:page animated:YES];
    }else if (indexPath.row == 1){
        PageListReportViewController *page = [[PageListReportViewController alloc] initWithListUserFollow];
        [[MainViewController getRootNaviController] pushViewController:page animated:YES];
    }else if(indexPath.row == 2){
        PageListReportViewController *page = [[PageListReportViewController alloc] initWithListUserRequest];
        [[MainViewController getRootNaviController] pushViewController:page animated:YES];
    }
}




@end
