//
//  SegmentListAlbum.h
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentController.h"

@protocol SegmentDelegate <NSObject>
-(void) segmentDidSelectRowAtIndex:(NSInteger)index;
@end

@interface SegmentView : UIView<SegmentControllerDelegate>
{
    NSArray *listItem;
    SegmentController *controller;
    IBOutlet UICollectionView *collectionView;
    
}

@property (nonatomic, strong) id<SegmentDelegate> delegate;

-(void)initViewWithList;

- (void) disableTableViewScroll;

- (void) enableCollectionScroll;

- (void) selectedIndex:(int) index;

@end
