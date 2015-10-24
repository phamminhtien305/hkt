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
#import "NewsCell.h"
#import "AddNewReportCell.h"

#import "AddReportViewController.h"
#import "ReportDetailViewController.h"

@implementation ListReportController
-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView withListItem:(NSMutableArray *)items forListReport:(BOOL)isReport{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        listItem = [[NSMutableArray  alloc] initWithArray:items];
        listSection = [[NSMutableArray alloc] initWithObjects:listItem, nil];
        [self updateCollectionViewWithListItem:listSection];
        if([listItem count] == 0){
            if(isReport){
                [self getListReportFromParse];
            }else{
                [self getListNewsFromParse];
            }
            _isReport = isReport;
        }
        [self setUpEgoRefreshHeader];
    }
    return self;
}


-(void)setUpEgoRefreshHeader{
    self.isLoadingRefreshHeader = NO;
    if(!self.refreshHeaderView){
        self.refreshHeaderView = [[BaseRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.targetCollectionView.bounds.size.height, [DeviceHelper getWinSize].width, self.targetCollectionView.bounds.size.height)];
        [self.refreshHeaderView setBackgroundColor:[UIColor whiteColor]];
        self.refreshHeaderView.delegate = self;
        [self.targetCollectionView addSubview:self.refreshHeaderView];
    }else{
        [self.refreshHeaderView setFrame:CGRectMake(self.refreshHeaderView.frame.origin.x,self.refreshHeaderView.frame.origin.y, [DeviceHelper getWinSize].width,self.refreshHeaderView.frame.size.height)];
    }
}


-(void)getListReportFromParse{
    isLoading = YES;
    [[APIEngineer sharedInstance] getReportsItemContentOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [listItem removeAllObjects];
            [listItem addObject:@"Bạn muốn báo cáo gì?"];
            [listItem addObjectsFromArray:[ReportItemObject createListDataFromListDict:result]];
            [self reloadCollectionView];
        }
        isLoading = NO;
    } onError:^(NSError *error) {
        isLoading = NO;        
    }];
}

-(void)getListNewsFromParse{
    [[APIEngineer sharedInstance] getNewsItemContentOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [listItem removeAllObjects];
            [listItem addObjectsFromArray:[ReportItemObject createListDataFromListDict:result]];
            [self reloadCollectionView];
        }
    } onError:^(NSError *error) {
        
    }];
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:BACKGROUND_COLLECTION];
    [collectionView registerNib:[ReportItemCell nib] forCellWithReuseIdentifier:[ReportItemCell nibName]];
    [collectionView registerNib:[NewsCell nib] forCellWithReuseIdentifier:[NewsCell nibName]];
    [collectionView registerNib:[AddNewReportCell nib] forCellWithReuseIdentifier:[AddNewReportCell nibName]];
    
}

-(NSString *)getCellIdentifierWithItem:(id)item{
    if(_isReport){
        if([item isKindOfClass:[NSString class]]){
            return [AddNewReportCell nibName];
        }
        return [ReportItemCell nibName];
    }
    return [NewsCell nibName];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_isReport){
        id item = [self itemAtIndexPath:indexPath];
        if([item isKindOfClass:[NSString class]]){
            return [AddNewReportCell getSize];
        }
        return [ReportItemCell getSize];
    }
    return [NewsCell getSize];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    if(_isReport){
        if([item isKindOfClass:[NSString class]]){
            AddReportViewController *reportView = [[AddReportViewController alloc] initUsingNib];
            [[MainViewController getRootNaviController] pushViewController:reportView animated:YES];
        }else{
            ReportDetailViewController *reportDetailView = [[ReportDetailViewController alloc] initWithReportItem:item];
            [[MainViewController getRootNaviController] pushViewController:reportDetailView animated:YES];
        }
    }else{
        if([item isKindOfClass:[ReportItemObject class]]){
            ReportDetailViewController *reportDetailView = [[ReportDetailViewController alloc] initWithReportItem:item];
            [[MainViewController getRootNaviController] pushViewController:reportDetailView animated:YES];
        }
    }
}



#pragma mark - Ego pull to refresh protocol
#pragma mark - Ego refresh header protocol
- (void) doneLoadingTableViewData {
    //  model should call this when its done loading
    self.isLoadingRefreshHeader = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.targetCollectionView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.refreshHeaderView) {
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.refreshHeaderView) {
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    if (self.refreshHeaderView) {
        if(!isLoading){
            if(_isReport){
                [self getListReportFromParse];
            }else{
                [self getListNewsFromParse];
            }
        }
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    if (!self.refreshHeaderView) {
        return NO;
    }
    return self.isLoadingRefreshHeader; // should return if data source model is reloading
}

- (NSDate*) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    if (!self.refreshHeaderView) {
        return nil;
    }
    return [NSDate date]; // should return date data source was last changed
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
