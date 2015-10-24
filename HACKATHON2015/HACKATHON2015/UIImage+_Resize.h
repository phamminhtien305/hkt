//
//  UIImage+_Resize.h
//  AppComic
//
//  Created by Minh Tien on 12/28/14.
//  Copyright (c) 2014 Minh Tien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (_Resize)
-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

-(UIImage*)scaleToSize:(CGSize)size;

- (UIImage *)centerCropImage:(UIImage *)image;
@end
