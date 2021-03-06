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
#import "ContactUsView.h"

@implementation InfoAppController

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listSection = [[NSMutableArray alloc] init];
        [self addAppInfo];
        [self updateCollectionViewWithListItem:listSection];
        __weak InfoAppController *weaksef = self;
        [self addHotLineOnComplete:^(BOOL b) {
            __strong InfoAppController * strongSelf = weaksef;
            [strongSelf addLocation];
        } onError:^(NSError *error) {
            __strong InfoAppController * strongSelf = weaksef;
            [strongSelf addLocation];
        }];
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

-(void)addHotLineOnComplete:(AppBOOLBlock)onComplete
                    onError:(AppResultErrorBlock)err
{
    [[APIEngineer sharedInstance] getHotLines:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]])
        {
            [listSection addObject:[HotLineObject createListDataFromPFObject:result]];
            [self updateCollectionViewWithListItem:listSection];
            onComplete(YES);
        }else
        {
            onComplete(NO);
        }
    } onError:^(NSError *error) {
        err(error);
    }];

}

-(void)addLocation{
    [[APIEngineer sharedInstance] getLocationService:^(id result, BOOL isCache)
     {
         [listSection addObject:[LocalServiceObject createListDataFromPFObject:result]];
         [self addAboutMe];
    } onError:^(NSError *error) {
        [self addAboutMe];
    }];
}

-(void)addAboutMe{
    NSDictionary *contactUs = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"value",@"Contact us",@"title", nil];
    
    NSArray *listItem = [[NSArray alloc] initWithObjects:contactUs, nil];
    [listSection addObject:listItem];
    [self updateCollectionViewWithListItem:listSection];
}


-(void)registerNibWithCollection:(UICollectionView *)collectionView
{
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [collectionView registerNib:[InfoCell nib] forCellWithReuseIdentifier:[InfoCell nibName]];
    [collectionView registerNib:[HeaderInfoView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderInfoView nibName]];
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    return [InfoCell nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [InfoCell getSize];
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return [HeaderInfoView getSize];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderInfoView *collectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HeaderInfoView nibName] forIndexPath:indexPath];
        reusableView = collectionHeader;
        NSString *titleHeader = @"";
        switch (indexPath.section) {
            case 0:
                titleHeader = @"THÔNG TIN ỨNG DỤNG";
                break;
            case 1:
                titleHeader = @"HOT LINE";
                break;
            case 2:
                titleHeader = @"TRA CỨU NHANH";
                break;
            case 3:
                titleHeader = @"PHẢN HỒI";
                break;
            default:
                break;
        }
        [collectionHeader configHeader:titleHeader];
    }
    return reusableView;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
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
    if(indexPath.section == 3){
        [ContactUsView showContactUsView];
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
