//
//  ListRecentViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface PageMapReportViewController : BaseViewController<GMSMapViewDelegate>
{
    GMSMapView *mapView_;
    __weak IBOutlet UIView *controlView;
    __weak IBOutlet UIButton *btnAll, *btnOpen, *btnClose, *btnSubmited, *btnMove;
    
}
@end
