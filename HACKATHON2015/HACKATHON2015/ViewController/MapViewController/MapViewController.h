//
//  MapViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ReportItemObject.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : BaseViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
{
    NSString *title, *description;
    float latitude, longtitude;
    IBOutlet GMSMapView *mapView;
    BOOL updatedLocation;
    id item_;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;

-(id)initWithItem:(id)item;

@end
