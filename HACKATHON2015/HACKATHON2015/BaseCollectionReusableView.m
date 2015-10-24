//
//  BaseCollectionReusableView.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@implementation BaseCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    
}

+(CGSize)getSize{
    return CGSizeMake(50.0, 50.0);
}
+(UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+(NSString *)nibName{
    return NSStringFromClass([self class]);
}

-(void)configHeader:(id)data{
    
}


@end
