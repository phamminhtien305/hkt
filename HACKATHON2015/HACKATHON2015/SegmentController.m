//
//  SegmentListAlbumController.m
//  MTLab
//
//  Created by Minh Tien on 8/5/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "SegmentController.h"
#import "SegmentCell.h"
@implementation SegmentController


-(id)initWithTargetCollection:(UICollectionView *)targetCollectionView withListItem:(NSArray *)listItem{
    self = [super initWithTargetCollection:targetCollectionView];
    if(self){
        _listItem = listItem;
        listSection = [[NSMutableArray alloc] initWithObjects:_listItem, nil];
        [self updateCollectionViewWithListItem:listSection];
    }
    return self;
}

-(void)registerNibWithCollection:(UICollectionView *)collectionView{
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerNib:[SegmentCell nib] forCellWithReuseIdentifier:[SegmentCell nibName]];
    
}


-(NSString *)getCellIdentifierWithItem:(id)item{
    return [SegmentCell nibName];
}

-(void)setCurrentIndex:(int)index{
    currentIndex = index;
    [self reloadCollectionView];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    NSString *cellIdentify = [self getCellIdentifierWithItem:item];
    
    SegmentCell *cell = (SegmentCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    if(indexPath.row == currentIndex){
        [cell configCell:item withSelected:YES];
    }else{
        [cell configCell:item withSelected:NO];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [SegmentCell getSize];
}



-(void)nextIndex{
    dispatch_async(dispatch_get_main_queue(), ^{
        currentIndex ++;
        if([self.items count] > 0){
            if(currentIndex >= (int)[[self.items objectAtIndex:0] count]){
                currentIndex =0;
            }
        }
        NSLog(@"Current index %d",currentIndex);
        [self reloadCollectionView];
        [self.targetCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(indexChange:)]){
            [self.delegate indexChange:currentIndex];
        }
    });
    
}

-(void)prvIndex{
    dispatch_async(dispatch_get_main_queue(), ^{
        currentIndex --;
        if([self.items count] > 0){
            if(currentIndex <0){
                currentIndex = (int)[[self.items objectAtIndex:0] count] - 1;
            }
        }
        NSLog(@"Current index %d",currentIndex);
        [self reloadCollectionView];
        [self.targetCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(indexChange:)]){
            [self.delegate indexChange:currentIndex];
        }
    });
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    currentIndex = (int)indexPath.row;
    if(self.delegate && [self.delegate respondsToSelector:@selector(indexChange:)]){
        [self.delegate indexChange:currentIndex];
    }
    
    [self reloadCollectionView];
}





@end
