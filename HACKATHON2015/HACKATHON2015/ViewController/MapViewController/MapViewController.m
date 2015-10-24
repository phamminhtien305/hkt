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

-(id)initWithItem:(id)item{
    self = [super initUsingNib];
    if(self){
        [self initMapOnComplete:^(BOOL b) {
            title = @"";
            if([item isKindOfClass:[ReportItemObject class]]){
                
                ReportItemObject *reportItem = (ReportItemObject *)item;
                
                title = [reportItem getTitle];
                description = [reportItem getDescription];
                
                latitude = [reportItem getLatitude];
                longtitude = [reportItem getLongtitude];
                
            }else if ([item isKindOfClass:[NewsObject class]]){
                
                NewsObject *newItem = (NewsObject *)item;
                
                title = [newItem getTitle];
                description = [newItem getDescription];
                
                longtitude = [newItem getLongtitude];
                latitude = [newItem getLatitude];
                
            }
            [self updateCurrenPointOnMap];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [[CLLocationManager alloc] init];
    [CLLocationManager locationServicesEnabled];
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
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude
                                                            longitude:mapView.myLocation.coordinate.longitude
                                                                 zoom:12];
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
    self.location = locations.lastObject;
    [mapView animateToLocation:self.location.coordinate];
    
    NSDictionary *result = [DeviceHelper convertCLLocationToDegreesFormula:self.location];
    
    latitude = self.location.coordinate.latitude;
    longtitude = self.location.coordinate.longitude;
    
    if(result){
        updatedLocation = YES;
    }
}

-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    return YES;
}




@end
