//
//  InfoAppController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "InfoAppController.h"
#import "InfoCell.h"
#import "HeaderInfoView.h"

#import "APIEngineer+Infomation.h"

@implementation InfoAppController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listSection = [[NSMutableArray alloc] init];
        [self addAppInfo];
        [self updateCollectionViewWithListItem:listSection];
//        [self getInfoApp];
    }
    return self;
}

-(void)addAppInfo{
    NSDictionary *buildObjectDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"value",@"Build",@"title", nil];
    NSDictionary *versionObjectDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1.0",@"value",@"Version",@"title", nil];
    NSDictionary *checkUpdateObjectDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"value",@"Check update",@"title", nil];
    
    NSArray *listItem = [[NSArray alloc] initWithObjects:versionObjectDic,buildObjectDic,checkUpdateObjectDic, nil];
    [listSection addObject:listItem];
}

-(void)getInfoApp{
    [[APIEngineer sharedInstance] getInfoAppOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [listSection removeAllObjects];
            [self addAppInfo];
            [listSection addObjectsFromArray:result];
            [self updateCollectionViewWithListItem:listSection];
        }
    } onError:^(NSError *error) {
        
    }];
}


-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [collectionView registerNib:[InfoCell nib] forCellWithReuseIdentifier:[InfoCell nibName]];
    [collectionView registerNib:[HeaderInfoView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderInfoView nibName]];
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    return [InfoCell nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [InfoCell getSize];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [HeaderInfoView getSize];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        id item = [self itemAtIndexPath:indexPath];
        HeaderInfoView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderInfoView nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        [collectionHeader configHeader:[item objectForKey:@"title"]];
    }
    return reusableView;
}


@end
