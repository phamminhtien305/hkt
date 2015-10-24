//
//  BaseCollectionReusableView.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionReusableView : UICollectionReusableView

+(CGSize)getSize;

+(UINib *)nib;

+(NSString *)nibName;

-(void)configHeader:(id)data;


@end
