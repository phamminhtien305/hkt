//
//  BannerView.h
//  Appvn
//
//  Created by tuent on 2/12/14.
//  Copyright (c) 2014 Appota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsObject.h"
#import "ReflectionView.h"

@interface BannerView : ReflectionView
{
    NSString *bannerImageUrl;
    NSString *bannerClickUrl;
    NSString *bannerDescription;
    NSString *bannerType;
    UIImageView *imgView;
    UILabel *bannerDescriptionLabel;
    //    NSDictionary *bannerDict;
    NewsObject *bannerData;
    UIImageView *shadowBg;
}

- (id) initWithBannerData:(NewsObject*) bData
           withBannerSize:(CGSize) bannerSize;

- (void) setBannerData:(NewsObject*) _bannerData;

- (NewsObject*) getBannerData;

@end
