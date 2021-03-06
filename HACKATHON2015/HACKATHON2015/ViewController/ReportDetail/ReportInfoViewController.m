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
#import "UploadEngine.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
@interface ReportInfoViewController ()

@end

@implementation ReportInfoViewController
-(id)initWithTitleName:(NSString *)title
{
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[MainViewController getRootNaviController] updateTitle:@"Thông Tin Báo Cáo"];
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
            
            isMapViewNormalShowning = YES;
            [btnMinimSize setHidden:YES];
            
            txtViewDescription.delegate = self;
            txtTitle.delegate = self;
            [txtTitle setText:_titleReport];
            txtViewDescription.layer.masksToBounds = YES;
            txtViewDescription.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            txtViewDescription.layer.cornerRadius = 10;
            txtViewDescription.layer.borderWidth = 0.5;

            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            [self.locationManager startUpdatingLocation];
            self.locationManager.delegate = self;
            self.location = [[CLLocation alloc] init];
            [self.locationManager startUpdatingHeading];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardDidShow:)
                                                         name:UIKeyboardDidShowNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardDidHide:)
                                                         name:UIKeyboardDidHideNotification
                                                       object:nil];
    });
    
    [self setupTakePhotoView];
    shareWithPublic = YES;
    isanym = NO;
    [self.view setBackgroundColor:BACKGROUND_COLLECTION];
}

-(void)setupTakePhotoView{
    takePhotoView.layer.cornerRadius = takePhotoView.frame.size.width/2;
    takePhotoView.layer.masksToBounds = YES;
    
}


-(void)keyboardDidShow:(NSNotification *)aNotification
{
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
    [mapView_.settings setAllGesturesEnabled:NO];
    // Creates a marker in the center of the map.
    onComplete(YES);
}

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations
{
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
        normalFrameMap = ownerMapView.frame;
    }];
}


-(IBAction)takePhoto:(id)sender
{
    [UIActionSheet showInView:self.view
                    withTitle:@"Chọn ảnh"
            cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"Chụp ảnh", @"Chọn trong thư viện"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                UIImagePickerController *picker;
                if (buttonIndex == 0)
                {
                    picker = [[UIImagePickerController alloc] init];
                    picker.delegate = self;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    picker.showsCameraControls = YES;
                }
                
                if (buttonIndex == 1)
                {
                    picker = [[UIImagePickerController alloc] init];
                    picker.delegate = self;
                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                
                if (picker) {
                    UIImagePickerControllerSourceType source = TARGET_IPHONE_SIMULATOR ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera;
                    if ([UIImagePickerController isSourceTypeAvailable:source]
                        ) {
                        [self presentViewController:picker animated:YES
                                         completion:^ {
                                             //                             [picker takePicture];
                                         }];
                    }
                }
            }];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //obtaining saving path
    [picker dismissViewControllerAnimated:YES completion:^{
     
        
    }];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *name = @"hkt.jpg";
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:name];
    
    //extracting image from the picker and saving it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
        // Write a UIImage to JPEG with minimum compression (best quality)
        // The value 'image' must be a UIImage object
        // The value '1.0' represents image compression quality as value from 0.0 to 1.0
        
            // Set desired maximum height and calculate width
            CGFloat width = image.size.width / 2;  // or whatever you need
            CGFloat height = (width / image.size.width) * image.size.height;
            
            // Resize the image
            UIImage *newImage = [image scaleToSize:CGSizeMake(width, height)];
//            newImage = [newImage centerCropImage:newImage];
            // Optionally save the image here...

        [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:imagePath atomically:YES];
        currentPath = imagePath;
        [thumbnail setImage:newImage];
        // Write image to PNG
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Bạn có muốn gửi thông báo này không?" delegate:self cancelButtonTitle:@"Hủy" otherButtonTitles:@"Gửi",nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[MainViewController getRootNaviController] popViewControllerAnimated:YES];
            break;
        case 1:
        {
            if(!currentPath){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Báo cáo của bạn đã được gửi đi." delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
                [alert show];
                break;
            }else{
                [[UploadEngine sharedInstance] uploadWithPath:currentPath withCompletionBlock:^(NSString *result) {
                    
                    PFObject *reportObject = [PFObject objectWithClassName:@"Report"];
                    reportObject[@"title"] = txtTitle.text;
                    
                    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
                    
                    reportObject[@"location"] = geoPoint;
                    
                    reportObject[@"images"] = [[NSArray alloc] initWithObjects:result, nil];
                    
                    PFUser *currUser = [PFUser currentUser];
                    PFRelation *relation = [reportObject relationForKey:@"owner"];
                    [relation addObject:currUser];
                    
                    description = txtViewDescription.text;
                    if(description)
                        reportObject[@"description"] = description;
                    
                    if(shareWithPublic){
                        reportObject[@"state"] = @"pending";
                    }else{
                        reportObject[@"state"] = @"private";
                    }
                    
                    reportObject[@"isanym"] = [NSNumber numberWithBool:YES];
                    
                    [reportObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            // The object has been saved.
                            [self checkLogin:^(BOOL b) {
                                if(b){
                                    [self postToFanPageWithReportObject:reportObject];
                                }
                            }];
                        } else {
                            // There was a problem, check error.description
                            [lbStatus setHidden:NO];
                        }
                    }];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Báo cáo của bạn đã được gửi đi." delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
                    [alert show];
                    
                } withErrorBlock:^(NSError *error) {
                    
                }];
                break;
            }
        }
        default:
            break;
    }
}

-(void)checkLogin:(AppBOOLBlock)onComplete{
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        // TODO: publish content.
        onComplete(YES);
    } else {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithPublishPermissions:@[@"publish_actions"]
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       onComplete(YES);
                                   }];
    }
}

-(void)postToFanPageWithReportObject:(PFObject *)report{
    NSArray *listImage = report[@"images"];
    if([listImage count]> 0){
        NSString *urlImage = [listImage firstObject];
        NSDictionary *params = @{
                                 @"message": report[@"description"],
                                 @"link": urlImage,
                                 @"published":@"1"
                                 };
        /* make the API call */
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"/1088242164520912/feed"
                                      parameters:params
                                      HTTPMethod:@"POST"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            // Handle the result
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vì Cộng Đồng" message:@"Image error!" delegate:self cancelButtonTitle:@"Ẩn thông báo" otherButtonTitles:nil];
        [alert show];
    }
    
}


-(IBAction)shareWithPublicHandle:(id)sender{
    UISwitch *sw = (UISwitch *)sender;
    shareWithPublic = [sw isOn];
}

-(IBAction)clickAnym:(id)sender{
    UISwitch *sw = (UISwitch *)sender;
    isanym = [sw isOn];
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [mapView clear];
    [mainScrollView bringSubviewToFront:ownerMapView];
    if(isMapViewNormalShowning){
        [UIView animateWithDuration:0.5 animations:^{
            [ownerMapView setFrame:CGRectMake(mainScrollView.frame.origin.x, mainScrollView.contentOffset.y, mainScrollView.frame.size.width, mainScrollView.frame.size.height - TABBAR_HEIGHT)];
        }completion:^(BOOL finished) {
            isMapViewNormalShowning = NO;
            [btnMinimSize setHidden:NO];
            [mapView_.settings setAllGesturesEnabled:YES];
            [[MainViewController getRootNaviController] hiddenNavigationButtonLeft:YES];
        }];
    }else{
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
