//
//  EventViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/30/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"
#import "ReportDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface EventViewController : BaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLLocationManagerDelegate, UITextViewDelegate, UITextFieldDelegate, GMSMapViewDelegate >{
    __weak IBOutlet GMSMapView *mapView_;
    __weak IBOutlet UIView *ownerMapView;
    float longtitude,latitude;
    BOOL updatedLocation;
    
    __weak IBOutlet UILabel *lbLocation;
    __weak IBOutlet UIScrollView *mainscroll;
    
    __weak IBOutlet UIButton *btnCreateEvent;
    
    __weak IBOutlet UITextField *textTitle;
    __weak IBOutlet UITextView *txtDescription;
    ReportDetailViewController *_owner;
    BOOL isMapViewNormalShowning;
    __weak IBOutlet UIButton *btnMinimSize;
    CGRect normalFrameMap;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;

-(id)initWithOwnerViewController:(ReportDetailViewController *)owner;


@end
