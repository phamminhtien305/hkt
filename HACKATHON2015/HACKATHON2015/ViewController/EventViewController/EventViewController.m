//
//  EventViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/30/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
        
    }];
    
    txtDescription.delegate =self;
    textTitle.delegate = self;
    
    [mainscroll setContentSize:CGSizeMake(mainscroll.frame.size.width, btnCreateEvent.frame.origin.y + btnCreateEvent.frame.size.height + 50)]; 
    
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




@end
