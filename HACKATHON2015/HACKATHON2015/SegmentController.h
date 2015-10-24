//
//  SegmentListAlbumController.h
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "BaseCollectionController.h"
@protocol SegmentControllerDelegate <NSObject>
@optional
-(void)indexChange:(int)index;
@end

@interface SegmentController : BaseCollectionController
{
    NSArray *_listItem;
    NSMutableArray *listSection;
    int currentIndex;
}

-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView withListItem:(NSArray *)listItem;

@property (nonatomic, strong) id<SegmentControllerDelegate>delegate;

-(void)setCurrentIndex:(int)index;
-(void)nextIndex;
-(void)prvIndex;



@end
