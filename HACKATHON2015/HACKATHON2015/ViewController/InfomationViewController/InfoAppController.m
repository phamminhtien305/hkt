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

#import "HotLineObject.h"
#import "LocalServiceObject.h"

#import "MapViewController.h"

@implementation InfoAppController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listSection = [[NSMutableArray alloc] init];
        [self addAppInfo];
        [self updateCollectionViewWithListItem:listSection];
        [self getInfoApp];
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
    [[APIEngineer sharedInstance] getHotLines:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [listSection removeAllObjects];
            [self addAppInfo];
            [listSection addObject:[HotLineObject createListDataFromPFObject:result]];
            [self updateCollectionViewWithListItem:listSection];
        }
        [[APIEngineer sharedInstance] getLocationService:^(id result, BOOL isCache) {
            [listSection addObject:[LocalServiceObject createListDataFromPFObject:result]];
            [self updateCollectionViewWithListItem:listSection];
        } onError:^(NSError *error) {
            
        }];
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
        HeaderInfoView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderInfoView nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        [collectionHeader configHeader:@""];
    }
    return reusableView;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    if(item){
        if([item isKindOfClass:[HotLineObject class]]){
            hotLineItemSelected = (HotLineObject *)item;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hot Line" message:[hotLineItemSelected getDescription] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }else if([item isKindOfClass:[LocalServiceObject class]]){
            LocalServiceObject *localService = (LocalServiceObject *)item;
            NSArray *listPoint = [localService listPoint];
            MapViewController *map = [[MapViewController alloc] initWithItems:listPoint withTitle:[localService getTitle]];
            [[MainViewController getRootNaviController] pushViewController:map animated:YES];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex > 0){
        NSString *hotLine = [hotLineItemSelected getHotLine];
        NSString *urlString = [NSString stringWithFormat:@"tel://%@",hotLine];
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:urlString]];
    }
}

-(void)alertViewCancel:(UIAlertView *)alertView{
    
}


@end
