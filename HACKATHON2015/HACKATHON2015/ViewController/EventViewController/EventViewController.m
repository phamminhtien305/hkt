//
//  EventViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/30/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "EventViewController.h"
#import <Parse/Parse.h>
#import "UIAlertView+Blocks.h"

@interface EventViewController ()

@end

@implementation EventViewController

-(id)initWithOwnerViewController:(ReportDetailViewController *)owner{
    self = [super initUsingNib];
    if(self){
        _owner = owner;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [btnMinimSize setHidden:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [CLLocationManager locationServicesEnabled];
    if([CLLocationManager locationServicesEnabled])
    {
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            [lbLocation setText:@"Location Services Disable"];
        }
    }else{
        [lbLocation setText:@"Location Services Disable"];
    }
    
    [self initMapOnComplete:^(BOOL b) {
         normalFrameMap = ownerMapView.frame;
    }];
    
    txtDescription.delegate =self;
    textTitle.delegate = self;
    
    [mainscroll setContentSize:CGSizeMake(mainscroll.frame.size.width, btnCreateEvent.frame.origin.y + btnCreateEvent.frame.size.height + 50)]; 
    isMapViewNormalShowning = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [mapView_.settings setAllGesturesEnabled:NO];
    // Creates a marker in the center of the map.
    onComplete(YES);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if(updatedLocation) return;
    self.location = locations.lastObject;
    [mapView_ animateToLocation:self.location.coordinate];
    
    NSDictionary *result = [DeviceHelper convertCLLocationToDegreesFormula:self.location];
    
    latitude = self.location.coordinate.latitude;
    longtitude = self.location.coordinate.longitude;
    
    if(result){
        [lbLocation setText:[NSString stringWithFormat:@"Location: %@-%@",[result objectForKey:@"latitude"],[result objectForKey:@"longtitude"]]];
        updatedLocation = YES;
    }
}

-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    return YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView setTextColor:[UIColor blackColor]];
    [textView  setText:@""];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"\n"]) {
        return NO; // or true, whetever you's like
    }
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}


#pragma mark - textfield delegate

#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}


-(IBAction)clickCreateEvent:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Bạn có muốn tạo sự kiện này không?" delegate:self cancelButtonTitle:@"Hủy" otherButtonTitles:@"Tạo",nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[MainViewController getRootNaviController] popViewControllerAnimated:YES];
            break;
        case 1:
        {
            PFObject *event = [PFObject objectWithClassName:@"Events"];
            event[@"title"] = textTitle.text;
            
            PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
            
            event[@"location"] = geoPoint;
            
            PFUser *currUser = [PFUser currentUser];
            PFRelation *relation = [event relationForKey:@"owner"];
            [relation addObject:currUser];
            
            NSString * description = txtDescription.text;
            if(description)
                event[@"description"] = description;
            
            [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Sự kiện của bạn đã được tạo." delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
                    [alert show];
                    if(_owner){
                        [_owner updateWithEvent:event];
                    }
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Nỗi kết nối vui lòng thử lại sau!" delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            break;
        }
        default:
            break;
    }
}




-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [mapView clear];
    [mainscroll bringSubviewToFront:ownerMapView];
    if(isMapViewNormalShowning){
        [UIView animateWithDuration:0.5 animations:^{
            [ownerMapView setFrame:CGRectMake(mainscroll.frame.origin.x, mainscroll.contentOffset.y, mainscroll.frame.size.width, mainscroll.frame.size.height - TABBAR_HEIGHT)];
        }completion:^(BOOL finished) {
            isMapViewNormalShowning = NO;
            [btnMinimSize setHidden:NO];
            [mapView_.settings setAllGesturesEnabled:YES];
            [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
        }];
    }else{
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude);
        marker.title = textTitle.text;
        marker.snippet = txtDescription.text;
        marker.map = mapView;
        marker.icon = [UIImage imageNamed:@"location_submited.png"];
        self.location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
        NSDictionary *result = [DeviceHelper convertCLLocationToDegreesFormula:self.location];
        if(result){
            [lbLocation setText:[NSString stringWithFormat:@"Location: %@-%@",[result objectForKey:@"latitude"],[result objectForKey:@"longtitude"]]];
            updatedLocation = YES;
        }
        latitude = self.location.coordinate.latitude;
        longtitude = self.location.coordinate.longitude;
    }
}

-(IBAction)clickMinisize:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        [ownerMapView setFrame:normalFrameMap];
    }completion:^(BOOL finished) {
        [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:NO];
        [btnMinimSize setHidden:YES];
        isMapViewNormalShowning = YES;
        [mapView_.settings setAllGesturesEnabled:NO];
    }];
}




@end
