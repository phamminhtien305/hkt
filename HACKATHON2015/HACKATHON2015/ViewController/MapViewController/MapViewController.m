//
//  MapViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "MapViewController.h"
#import "NewsObject.h"
@interface MapViewController ()

@end

@implementation MapViewController

-(id)initWithItems:(NSArray *)items
         withTitle:(NSString *)title_
{
    self = [super initUsingNib];
    if(self){
        title = title_;
        listPoint = items;
        isShowWithListPoint = YES;
    }
    
    return self;
}

-(id)initWithItem:(id)item{
    self = [super initUsingNib];
    if(self){
        item_ = item;
        isShowWithListPoint = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [[CLLocationManager alloc] init];
    [CLLocationManager locationServicesEnabled];

    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    [self.locationManager startUpdatingHeading];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:NO];
    [self initMapOnComplete:^(BOOL b) {

        if(!item_ && isShowWithListPoint){
            [mapView clear];
            for (NSString *locationStr in listPoint) {
                GMSMarker *marker = [[GMSMarker alloc] init];
                
                NSString *_latitude = [[locationStr componentsSeparatedByString:@","] firstObject];
                NSString *_longtitude = [[locationStr componentsSeparatedByString:@","] lastObject];
                marker.position = CLLocationCoordinate2DMake([_latitude  floatValue], [_longtitude floatValue]);
                marker.title = title;
                marker.snippet = @"";
                marker.map = mapView;
            }
            [mapView.settings setAllGesturesEnabled:YES];
        }else{
            title = @"";
            description  = @"";
            if([item_ isKindOfClass:[ReportItemObject class]]){
                
                ReportItemObject *reportItem = (ReportItemObject *)item_;
                
                title = [reportItem getTitle];
                description = [reportItem getDescription];
                
                latitude = [reportItem getLatitude];
                longtitude = [reportItem getLongtitude];
                
            }else if ([item_ isKindOfClass:[NewsObject class]]){
                
                NewsObject *newItem = (NewsObject *)item_;
                
                title = [newItem getTitle];
                description = [newItem getDescription];
                
                longtitude = [newItem getLongtitude];
                latitude = [newItem getLatitude];
                
            }
            [self updateCurrenPointOnMap];
        }
       
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateCurrenPointOnMap{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longtitude);
    marker.title = title;
    marker.snippet = description;
    marker.map = mapView;
}



-(void)initMapOnComplete:(AppBOOLBlock)onComplete{
    // Do any additional setup after loading the view from its nib.
    float zoomValue = 12;
    if(isShowWithListPoint){
        zoomValue = 14;
    }
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[item_ getLatitude]
                                                            longitude:[item_ getLongtitude]
                                                                 zoom:zoomValue];
    [mapView setCamera:camera];
    mapView.mapType = kGMSTypeNormal;
    mapView.accessibilityElementsHidden = YES;
    mapView.indoorEnabled = YES;
    mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    [mapView.settings setAllGesturesEnabled:NO];
    // Creates a marker in the center of the map.
    onComplete(YES);
}

#pragma mark - Location Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if(isShowWithListPoint){
        self.location = locations.lastObject;
        [mapView animateToLocation:self.location.coordinate];
        
        NSDictionary *result = [DeviceHelper convertCLLocationToDegreesFormula:self.location];
        
        latitude = self.location.coordinate.latitude;
        longtitude = self.location.coordinate.longitude;
        
        if(result){
            updatedLocation = YES;
        }
    }
}

-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    return YES;
}




@end
