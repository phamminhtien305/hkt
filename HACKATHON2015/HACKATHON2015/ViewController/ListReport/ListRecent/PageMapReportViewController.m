//
//  ListRecentViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "PageMapReportViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PageMapReportViewController ()

@end

@implementation PageMapReportViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    if(ADMIN == 0){
        [self setupForUser];
    }else{
        [self setupForAdmin];
    }
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:YES];
}


-(void)setupForAdmin{
    [btnAll setHidden:NO];
    [btnClose setHidden:NO];
    [btnMove setHidden:NO];
    [btnOpen setHidden:NO];
    [btnSubmited setHidden:NO];
}

-(void)setupForUser{
    [btnAll setHidden:YES];
    [btnClose setHidden:NO];
    [btnMove setHidden:NO];
    [btnOpen setHidden:NO];
    [btnSubmited setHidden:YES];
    [btnOpen setFrame:CGRectMake(10, btnOpen.frame.origin.y, btnOpen.frame.size.width, btnOpen.frame.size.height)];
    [btnClose setFrame:CGRectMake(btnOpen.frame.origin.x + btnOpen.frame.size.width + 10, btnClose.frame.origin.y, btnClose.frame.size.width, btnClose.frame.size.height)];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[MainViewController getRootNaviController] updateTitle:@"Map"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(!mapView_){
            mapView_ = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            if(mapView_.frame.size.height > [DeviceHelper getWinSize].height - TABBAR_HEIGHT - 64){
                mapView_ = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TABBAR_HEIGHT)];
            }
            [self.view insertSubview:mapView_ belowSubview:controlView];
            [self initMapOnComplete:^(BOOL b) {
                [self createLocationOnMap];
                [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
            }];
        }else{
            [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
        }
    });
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[MainViewController getRootNaviController] hiddenNavigationButtonRight:NO];
}


-(void)initMapOnComplete:(AppBOOLBlock)onComplete{
    // Do any additional setup after loading the view from its nib.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.027764
                                                            longitude:105.834160
                                                                 zoom:12];
    [mapView_ setCamera:camera];
    mapView_.mapType = kGMSTypeNormal;
    mapView_.accessibilityElementsHidden = YES;
    mapView_.indoorEnabled = YES;
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    [mapView_.settings setAllGesturesEnabled:YES];
    // Creates a marker in the center of the map.
    onComplete(YES);
}

-(void)createLocationOnMap{
    if(![MainViewController shareMainViewController].listReporterItem) return;
    for (ReportItemObject *item in [MainViewController shareMainViewController].listReporterItem) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([item getLatitude], [item getLongtitude]);
        marker.title = [item getTitle];
        marker.snippet = [item getDescription];
        marker.map = mapView_;
//        if([item state] == open_){
//            marker.icon = [UIImage imageNamed:@"location_opened.png"];
//        }else if([item state] == pending){
//            marker.icon = [UIImage imageNamed:@"location_submited.png"];
//        }else if([item state] == close_){
//            marker.icon = [UIImage imageNamed:@"location_closed.png"];
//        }else if([item state] == private_){
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)enableMove:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    [mapView_.settings setAllGesturesEnabled:btn.selected];
}




@end
