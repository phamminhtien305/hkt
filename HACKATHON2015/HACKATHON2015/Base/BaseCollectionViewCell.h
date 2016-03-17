//
//  BaseCollectionViewCell.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property BOOL lastCell;
- (void) configCell:(id) data;
-(void)configCellWithPath:(id)url;
- (void) selectCell:(id) data;
+(UINib *)nib;
+(NSString *)nibName;
+ (float) height;
+ (float) width;

+(CGSize)getSize;

@end
