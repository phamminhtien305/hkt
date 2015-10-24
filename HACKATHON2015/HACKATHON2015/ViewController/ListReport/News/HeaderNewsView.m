//
//  HeaderNewsView.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "HeaderNewsView.h"
#import "BannerView.h"

@implementation HeaderNewsView


- (void) awakeFromNib {
    [super awakeFromNib];
    self.carouselView.type = iCarouselTypeLinear;
    self.carouselView.decelerationRate = 0.5;
    self.carouselView.scrollToItemBoundary = YES;
}

+(CGSize)getSize{
    float _height = BannerHeight;
    return CGSizeMake([DeviceHelper getWinSize].width, _height);
}

-(void)configHeader:(id)data{
    if([data isKindOfClass:[NSArray class]]){
        self.carouselView.delegate = self;
        self.carouselView.dataSource = self;
        self.items = data;
        [self.carouselView reloadData];
        [self configPageControlWithNumberOfItem:(int)self.items.count];
    }
}


- (void) configPageControlWithNumberOfItem:(int)itemNum {
    float _height = BannerHeight;
    
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
    }
    CGRect pageControlRect = CGRectMake(self.frame.origin.x,_height - 14
                                        , itemNum*17.0f, 8.0);
    self.pageControl = [[BannerPageControl alloc] initWithFrame:pageControlRect];
    [self.pageControl addTarget:self action:@selector(changeBannerPage:) forControlEvents:UIControlEventValueChanged];
    
    self.pageControl.currentPage = 0;
    
    self.pageControl.numberOfPages = itemNum;
    self.pageControl.userInteractionEnabled =YES;
    self.pageControl.center = CGPointMake(self.center.x, _height -10);
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    
    [self.pageControl setOffColor:[UIColor colorWithWhite: 1.0f alpha:1.0f]];
    [self.pageControl setOnColor:[UIColor greenColor]];
    self.pageControl.hidden = NO;
    
    [self addSubview:self.pageControl];
}

#pragma mark - Carousel delegate
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.items ? self.items.count : 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(BannerView *)view {
    NewsObject * bannerData = [self.items objectAtIndex:index];
    if (view == nil){
        CGSize bannerSize = CGSizeMake([DeviceHelper getWinSize].width, BannerHeight);
        if([DeviceHelper isDeviceIPhone]){
            bannerSize = CGSizeMake([DeviceHelper getWinSize].width, BannerHeight - 2);
        }
        view = [[BannerView alloc] initWithBannerData:bannerData withBannerSize:bannerSize];
        if([DeviceHelper isDeviceIPad]){
            view.reflectionScale = 0.3;
            view.reflectionGap = 0;
            view.dynamic = YES;
        }
        
    } else {
        [view setBannerData:bannerData];
    }
    return view;
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    if (!self.pageControlBeingUsed) {
        self.pageControl.currentPage = self.carouselView.currentItemIndex;
    }
    else {
        self.pageControlBeingUsed = NO;
    }
}

- (void) carouselWillBeginScrollingAnimation:(iCarousel *)carousel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollStep) object:nil];
}

- (void) carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollStep) object:nil];
    [self performSelector:@selector(scrollStep) withObject:nil afterDelay:4.6];
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel {
    self.pageControlBeingUsed = NO;
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    self.pageControlBeingUsed = NO;
}


- (void) carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            // Use linear
            return value;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carouselView.type == iCarouselTypeCoverFlow)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionVisibleItems:
        {
            return 11;
        }
        default:
        {
            return value;
        }
    }
}

- (void)scrollStep
{
    [self performSelector:@selector(scrollStep) withObject:nil afterDelay:4.6];
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground)
        return;
    float timeChangeScroll = 0.4f;
    //don't autoscroll when user is manipulating carousel
    if (!self.carouselView.dragging && !self.carouselView.decelerating && !self.pageControlBeingUsed) {
        
        //        return;
        /*
         For low resorce device disable animation
         */
        if (LESS_THAN_OS7) {
            [self.carouselView scrollToItemAtIndex:self.carouselView.currentItemIndex + 1 animated:NO];
            return;
        }
        /*
         For iPad change normal anim
         */
        if ([DeviceHelper isDeviceIPad]) {
            [self.carouselView scrollToItemAtIndex:self.carouselView.currentItemIndex + 1 animated:YES];
            return;
        }
        
        [UIView animateWithDuration:timeChangeScroll animations:^{
            self.carouselView.currentItemView.alpha = 0.4f;
        } completion:^(BOOL finished) {
            self.carouselView.currentItemView.alpha = 1.0f;
            [self.carouselView scrollToItemAtIndex:self.carouselView.currentItemIndex + 1 animated:NO];
            self.carouselView.currentItemView.alpha = 0.4f;
            [UIView animateWithDuration:timeChangeScroll animations:^{
                self.carouselView.currentItemView.alpha = 1.0f;
            }];
        }];
    }
}

- (void)changeBannerPage:(id)sender {
    [self.carouselView scrollToItemAtIndex:self.pageControl.currentPage animated:YES];
    self.pageControlBeingUsed = YES;
}
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
