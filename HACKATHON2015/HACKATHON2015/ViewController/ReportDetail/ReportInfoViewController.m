//
//  ReportDetailViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "ReportInfoViewController.h"
#import "UIImage+_Resize.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "PageMapReportViewController.h"

@interface ReportInfoViewController ()

@end

@implementation ReportInfoViewController
-(id)initWithTitleName:(NSString *)title{
    self = [super initUsingNib];
    if(self){
        _titleReport = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [lbStatus setHidden:YES];
    
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
    
    txtViewDescription.delegate = self;
    txtTitle.delegate = self;
    [txtTitle setText:_titleReport];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    [self.locationManager startUpdatingHeading];
    
    if([MainViewController shareMainViewController].reporter){
        [lbReporter setText:[NSString stringWithFormat:@"Reporter: %@ %@",[[MainViewController shareMainViewController].reporter getReporterFirstName], [[MainViewController shareMainViewController].reporter  getReporterLastName]]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}


-(void)keyboardDidShow:(NSNotification *)aNotification{
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, mainScrollView.contentSize.height + 170)];
}

-(void)keyboardDidHide:(NSNotification *)aNotification{
    [mainScrollView setContentSize:CGSizeMake([DeviceHelper getWinSize].width, btnReport.frame.origin.y +  btnReport.frame.size.height + 20)];
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
    [mapView_.settings setAllGesturesEnabled:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    updatedLocation = NO;
    [mainScrollView setContentSize:CGSizeMake([DeviceHelper getWinSize].width, btnReport.frame.origin.y +  btnReport.frame.size.height + 20)];
    [self initMapOnComplete:^(BOOL b) {
        
    }];
}


-(IBAction)takePhoto:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    picker.showsCameraControls = YES;
    
    [self presentViewController:picker animated:YES
                     completion:^ {
                         [picker takePicture];
                     }];

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //obtaining saving path
    [picker dismissViewControllerAnimated:YES completion:^{
     
        
    }];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *time = [NSString stringWithFormat:@"%@",[NSDate date]];
    NSString *name = [@"Hackathon-" stringByAppendingString:time];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:name];
    
    //extracting image from the picker and saving it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        // Write a UIImage to JPEG with minimum compression (best quality)
        // The value 'image' must be a UIImage object
        // The value '1.0' represents image compression quality as value from 0.0 to 1.0
        
            // Set desired maximum height and calculate width
            CGFloat width = image.size.width;  // or whatever you need
            CGFloat height = (width / image.size.width) * image.size.height;
            
            // Resize the image
            UIImage *newImage = [image scaleToSize:CGSizeMake(width, height)];
            newImage = [newImage centerCropImage:newImage];
        
            // Optionally save the image here...

        [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:imagePath atomically:YES];
            [thumbnail setImage:newImage];
        // Write image to PNG
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [lbStatus setHidden:YES];
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView setTextColor:[UIColor blackColor]];
    [textView  setText:@""];
    [lbStatus setHidden:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"\n"]) {
        return NO; // or true, whetever you's like
        [lbStatus setHidden:YES];
    }
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [lbStatus setHidden:YES];
    }
    return YES;
}


#pragma mark - textfield delegate

#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [lbStatus setHidden:YES];
    return YES;
}

- (BOOL) textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Check the replacementString
    [lbStatus setHidden:YES];
    return YES;
}


-(IBAction)clickSubmit:(id)sender{
    if([MainViewController shareMainViewController].reporter){
        ReporterObject *reporter = [MainViewController shareMainViewController].reporter;

        PFObject *reportObject = [PFObject objectWithClassName:@"Report"];
        reportObject[@"title"] = txtTitle.text;
        
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
        
        reportObject[@"location"] = geoPoint;
        
        reportObject[@"state"] = @"pending";
        reportObject[@"images"] = [[NSArray alloc] initWithObjects:@"http://4.bp.blogspot.com/-nk0SSzm41HE/VVQeWMQ3iRI/AAAAAAAAALk/a9EWLZ8JCvc/s1600/a4f998e11a3aeecec34dfbf296d4120f_61-0513.jpg",@"http://hanoimoi.com.vn/Uploads/trieuhoa/2015/8/4/duong5.jpg",@"http://img.vietnamplus.vn/t660/Uploaded/mzdiq/2015_06_13/vnp_muagiong2.jpg",@"http://media.tinmoi.vn/2015/03/13/resized__MG_8596.JPG", nil];
        
        description = txtViewDescription.text;
        if(description)
            reportObject[@"description"] = description;
        
//        NSData *imageData = UIImagePNGRepresentation(thumbnail.image);
//        if(imageData){
//            PFFile *imageFile = [PFFile fileWithName:@"thum" data:imageData];
//            [reportObject setObject:imageFile forKey:@"imageFile"];
//        }
//        

        [reportObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                [[MainViewController getRootNaviController] popViewControllerAnimated:YES];
            } else {
                // There was a problem, check error.description
                [lbStatus setHidden:NO];
            }
        }];
    }
}

-(IBAction)shareWithPublicHandle:(id)sender{
    UISwitch *sw = (UISwitch *)sender;
    shareWithPublic = [sw isOn];
}


-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [mapView clear];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude);
    marker.title = _titleReport;
    marker.snippet = description;
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


@end
