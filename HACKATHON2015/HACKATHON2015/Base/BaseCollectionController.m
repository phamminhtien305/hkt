 //
//  BaseCollectionController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionController.h"

@implementation BaseCollectionController

- (id) initWithTargetCollection:(UICollectionView *)targetCollectionView{
    self = [super init];
    if (self) {
        self.items = [NSArray new];
        self.targetCollectionView = targetCollectionView;
        self.targetCollectionView.delegate = self;
        self.targetCollectionView.dataSource = self;
        [self registerNibWithCollection:self.targetCollectionView];
        contentOffset = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setUpEgoRefreshHeader];
        });
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



- (id) initWithTargetCollection:(UICollectionView*) targetCollectionView
                 withParamsDict:(NSMutableDictionary*) params{
    self = [self initWithTargetCollection:targetCollectionView];
    return self;
}

- (void) registerNibWithCollection:(UICollectionView*)collectionView{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    
}

- (NSString*) getCellIdentifierWithItem:(id) item{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}

- (void) updateCollectionViewWithListItem:(NSArray*) listItems{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.items = listItems;
        [self.targetCollectionView reloadData];
    });
}

- (void) reloadCollectionView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.targetCollectionView reloadData];
    });
}

-(NSArray*) getListItem {
    return self.items;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    @synchronized(self.items) {
        if (self.items == nil)
            return nil;
        if (self.items && [self.items[indexPath.section] count] <= indexPath.row)
            return nil;
        id item = [self.items[indexPath.section] objectAtIndex:indexPath.row];
        return item;
    }
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items ? [self.items count] : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger number_row = [[self.items objectAtIndex:section] count] ? [[self.items objectAtIndex:section] count]:0;
    return number_row;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath];
    NSString *cellIdentify = [self getCellIdentifierWithItem:item];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configCell:)]) {
        [(BaseCollectionViewCell*) cell setCellIndexPath:indexPath];
        
        ((BaseCollectionViewCell*) cell).cellIndexPath = indexPath;
     
        if(indexPath.row == [collectionView numberOfItemsInSection:indexPath.section] - 1){
            ((BaseCollectionViewCell*) cell).lastCell = YES;
        }else{
            ((BaseCollectionViewCell*) cell).lastCell = NO;
        }
        [((BaseCollectionViewCell*) cell) configCell:item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
    if (self.refreshHeaderView)
    {
        [self refreshHeaderHandle:view];
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

-(void)refreshHeaderHandle:(id)handle{}



@end
