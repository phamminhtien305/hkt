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
        [self getInfoApp];
    }
    return self;
}

-(void)getInfoApp{
    [[APIEngineer sharedInstance] getInfoAppOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [listSection removeAllObjects];
            [listSection addObjectsFromArray:result];
            [self updateCollectionViewWithListItem:listSection];
        }
    } onError:^(NSError *error) {
        
    }];
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = [self.items objectAtIndex:indexPath.section];
    if([item  objectForKey:@"list"] && [[item objectForKey:@"list"] isKindOfClass:[NSArray class]]){
        NSArray *list = [item objectForKey:@"list"];
        if ([list count] > indexPath.row) {
            return [list objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *item = [self.items objectAtIndex:section];
    if([item  objectForKey:@"list"] && [[item objectForKey:@"list"] isKindOfClass:[NSArray class]]){
        NSInteger number_row = [[item objectForKey:@"list"] count] ? [[item objectForKey:@"list"] count]:0;
        return number_row;
    }
    return 0;
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
        id item = [listSection objectAtIndex:indexPath.section];
        HeaderInfoView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderInfoView nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        [collectionHeader configHeader:[item objectForKey:@"title"]];
    }
    return reusableView;
}


@end
