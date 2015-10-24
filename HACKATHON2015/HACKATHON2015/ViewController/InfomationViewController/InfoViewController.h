//
//  InfoViewController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoAppController.h"
@interface InfoViewController : BaseViewController
{
    InfoAppController *controller;
    __weak IBOutlet UICollectionView *collectionView;
}

@end
