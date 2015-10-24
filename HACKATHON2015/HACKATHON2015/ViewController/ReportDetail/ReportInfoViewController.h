//
//  ReportDetailViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ReportInfoViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLLocationManagerDelegate, UITextViewDelegate, UITextFieldDelegate, GMSMapViewDelegate>
{
    __weak IBOutlet UIScrollView *mainScrollView;
    __weak IBOutlet UIView *reportView;
    
    __weak IBOutlet UIImageView *thumbnail;
    __weak IBOutlet UILabel *lbLocation, *lbStatus;
    float longtitude,latitude;
    NSString *description, *_titleReport;
    BOOL shareWithPublic, isanym;

    __weak IBOutlet UITextView *txtViewDescription;
    __weak IBOutlet UITextField *txtTitle;
    __weak IBOutlet UIButton *btnReport;
    __weak IBOutlet UILabel *lbReporter;
    
    __weak IBOutlet GMSMapView *mapView_;
    
    __weak IBOutlet UIView *takePhotoView;
    
    NSString *currentPath;
    
    BOOL updatedLocation;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;

-(id)initWithTitleName:(NSString *)title;

@end
