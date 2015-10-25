//
//  ListReportViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ListReportViewController.h"
#import "PageListReportViewController.h"
#import "PageMapReportViewController.h"
#import "PageNewsViewController.h"
#import "APIEngineer+Report.h"

@interface ListReportViewController ()

@end

@implementation ListReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MainViewController getRootNaviController] updateTitle:APP_NAME];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
    // Do any additional setup after loading the view from its nib.
    listItem = [[NSMutableArray alloc] init];
    [self setupSegment];
    [self setupPageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[MainViewController getRootNaviController] updateTitle:APP_NAME];
    
    [pageViewController.view setFrame:CGRectMake(0, segmentView.frame.origin.y + segmentView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - segmentView.frame.size.height - TABBAR_HEIGHT)];
    [self getListReportFromParse];
    
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
}


-(void)getListReportFromParse{
    [[APIEngineer sharedInstance] getReportsItemContentOnComplete:^(id result, BOOL isCache) {
        if(result && [result isKindOfClass:[NSArray class]]){
            [MainViewController shareMainViewController].listReporterItem = [[ReportItemObject createListDataFromPFObject:result] mutableCopy];
        }
    } onError:^(NSError *error) {
        
    }];
}

#pragma mark - Setup PageView
-(void)setupPageView{
    PageListReportViewController *favorite = [[PageListReportViewController alloc] initUsingNib];
    PageMapReportViewController *map = [[PageMapReportViewController alloc] initUsingNib];
    PageNewsViewController *news = [[PageNewsViewController alloc] initUsingNib];
    
    listPage = [[NSArray alloc] initWithObjects:favorite,map,news, nil];

    pageViewController = [[BasePageViewController alloc] initWithListViewControllers:listPage withRootViewController:self];
    pageViewController.delegate = self;
    segmentView.delegate = self;
}

-(void)pageChange:(int)index{
    [segmentView selectedIndex:index];
}

- (UIViewController *)tabSwipeNavigationViewControllerAtIndex:(NSUInteger)index{
    if(index < [listPage count]){
        return [listPage objectAtIndex:index];
    }
    return [listPage firstObject];
}

-(void)indexChange:(int)index{
    [pageViewController setSelectedPageWithIndex:(int)index];
}

-(void)segmentDidSelectRowAtIndex:(NSInteger)index{
    [pageViewController setSelectedPageWithIndex:(int)index];
}

-(void)setupSegment{
    [segmentView initViewWithList];
}

@end
