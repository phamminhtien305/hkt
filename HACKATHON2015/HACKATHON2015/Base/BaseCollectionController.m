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
    }
    
    return self;
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
        [((BaseCollectionViewCell*) cell) configCell:item];
        ((BaseCollectionViewCell*) cell).cellIndexPath = indexPath;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}



@end
