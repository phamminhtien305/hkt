//
//  BasePageViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "BaseViewController.h"
@protocol PageViewControllerDelegate <NSObject>

@required
- (UIViewController *)tabSwipeNavigationViewControllerAtIndex:(NSUInteger)index;

@optional
-(void)pageChange:(int)index;
- (void) handleScrollAnimatingWithScrollingValue:(float)scrollingValue;
@end


@interface BasePageViewController : BaseViewController <UIPageViewControllerDelegate, UIScrollViewDelegate, UIPageViewControllerDataSource>{
    float currentContentOffsetx;
    int currentindex;
    
    NSUInteger numberOfTabs;
    NSInteger selectedIndex;
    BaseViewController *rootViewController;
    UIPageViewController *pageController;
}

- (id) initWithListViewControllers:(NSArray*) listViewControllers withRootViewController:(BaseViewController *)root;

@property BOOL checkLowDevice;

@property (nonatomic, strong) NSObject<PageViewControllerDelegate> * delegate;
@property (nonatomic, strong) BaseViewController *ownerViewcontroller;
@property (strong, nonatomic) NSArray *listViewControllers;

-(void)setSelectedPageWithIndex:(int)index;

@end
