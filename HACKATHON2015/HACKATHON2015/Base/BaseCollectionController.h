//
//  BaseCollectionController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCollectionController : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>{
    float contentOffset;
    float startDragX, targetOffsetX;

}


@property (nonatomic, strong) BaseViewController *ownerViewController;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, retain) UICollectionView *targetCollectionView;

@property (nonatomic, readwrite) BOOL scrollPageEnable;
@property (nonatomic, readwrite) float scrollPageWidth;

- (id) initWithTargetCollection:(UICollectionView *)targetCollectionView;

- (id) initWithTargetCollection:(UICollectionView*) targetCollectionView
                 withParamsDict:(NSMutableDictionary*) params;

- (void) registerNibWithCollection:(UICollectionView*)collectionView;

- (NSString*) getCellIdentifierWithItem:(id) item;

- (void) updateCollectionViewWithListItem:(NSArray*) listItems;

- (void) reloadCollectionView;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
