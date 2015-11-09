//
//  SegmentListAlbum.m
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "SegmentView.h"

@implementation SegmentView

-(void)initViewWithList{
    listItem = [[NSArray alloc] initWithObjects:@"Báo cáo",@"Bản đồ",@"Tin tức", nil];
    controller = [[SegmentController alloc] initWithTargetCollection:collectionView
                                                        withListItem:listItem];
    controller.delegate = self;
    [self setBackgroundColor:BACKGROUND_NAVIGATIONBAR];
}


-(void)indexChange:(int)index{
    if(self.delegate && [self.delegate respondsToSelector:@selector(segmentDidSelectRowAtIndex:)])
    {
        [self.delegate segmentDidSelectRowAtIndex:index];
    }
}


- (void) disableTableViewScroll{
    collectionView.scrollEnabled = NO;
}

- (void) enableCollectionScroll{
    collectionView.scrollEnabled = YES;
}

- (void) selectedIndex:(int) index{
    [controller setCurrentIndex: index];
}




@end
