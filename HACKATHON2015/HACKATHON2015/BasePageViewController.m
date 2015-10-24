//
//  BasePageViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 Minh Tien. All rights reserved.
//

#import "BasePageViewController.h"
#import "PageListReportViewController.h"
#import "PageMapReportViewController.h"
#import "PageNewsViewController.h"

@interface BasePageViewController ()

@end

@implementation BasePageViewController

- (id) initWithListViewControllers:(NSArray*) listViewControllers withRootViewController:(BaseViewController *)root{
    self = [self init];
    if (self) {
        rootViewController = root;
        self.listViewControllers = listViewControllers;
        numberOfTabs = [listViewControllers count];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupPageViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup pageViewController
- (void) setupPageViewController
{
    // create page controller
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                     options:nil];
    pageController.delegate = self;
    pageController.dataSource = self;
    
    // delegate scrollview
    for (UIView *v in pageController.view.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)v).delegate = self;
        }
    }
    
    // add page controller as child
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
    
    // add self as child to parent
    [rootViewController addChildViewController:self];
    [rootViewController.view addSubview:self.view];
    [self didMoveToParentViewController:rootViewController];
    
    id viewController = [self.delegate tabSwipeNavigationViewControllerAtIndex:selectedIndex];
    [pageController setViewControllers:@[viewController]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:^(BOOL finished) {
                            }];
}

# pragma mark - PageViewController DataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = selectedIndex;
	if (index++ < numberOfTabs - 1 && index <= numberOfTabs - 1) {
        UIViewController *nextViewController = [self.delegate tabSwipeNavigationViewControllerAtIndex:index];
        return nextViewController;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = selectedIndex;
	if (index-- > 0) {
        UIViewController *nextViewController = [self.delegate tabSwipeNavigationViewControllerAtIndex:index];
        return nextViewController;
    }

    return nil;
}

# pragma mark - PageViewController Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (!completed)
        return;
    
    id currentView = [pageViewController.viewControllers objectAtIndex:0];
    if([currentView isKindOfClass:[PageListReportViewController class]]){
        selectedIndex = 0;
    }else if([currentView isKindOfClass:[PageMapReportViewController class]]){
        selectedIndex = 1;
    }else if([currentView isKindOfClass:[PageNewsViewController class]]){
        selectedIndex = 2;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageChange:)]){
        [self.delegate pageChange:(int)selectedIndex];
    }
}

-(void)setSelectedPageWithIndex:(int)index{
    id viewController = [self.listViewControllers objectAtIndex:index];
    __weak __typeof__(self) weakSelf = self;

    [pageController setViewControllers:@[viewController]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:YES
                            completion:^(BOOL finished) {
                                __strong __typeof__(self) strongSelf = weakSelf;
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    selectedIndex = index;
                                });

                            }];
}


@end

