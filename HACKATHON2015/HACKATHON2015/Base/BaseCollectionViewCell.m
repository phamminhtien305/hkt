//
//  BaseCollectionViewCell.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

+(UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+(NSString *)nibName{
    return NSStringFromClass([self class]);
}

+(float)height{
    return 130.0f;
}

+(float)width{
    return 130.0f;
}

- (void) selectCell:(id) data {
    
}

- (void) configCell:(id) data {}

- (void) configCellWithPath:(id)url{}

- (void) removeHandlers {
    
}

+(CGSize)getSize{
    return CGSizeMake(50.0, 50.0);
}

@end
