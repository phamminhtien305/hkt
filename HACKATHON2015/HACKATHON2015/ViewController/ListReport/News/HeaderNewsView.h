//
//  HeaderNewsView.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionReusableView.h"
#import <iCarousel/iCarousel.h>
#import "BannerPageControl.h"
#import "NewsObject.h"

@interface HeaderNewsView : BaseCollectionReusableView<iCarouselDataSource,iCarouselDelegate>{
    
}

@property (unsafe_unretained, nonatomic) IBOutlet iCarousel *carouselView;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) BannerPageControl *pageControl;

@property (readwrite) BOOL pageControlBeingUsed;

@property (nonatomic, strong) BaseViewController *ownerViewcontroller;



@end
