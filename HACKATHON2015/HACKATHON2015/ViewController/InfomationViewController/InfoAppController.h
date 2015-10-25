//
//  InfoAppController.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseCollectionController.h"
#import "HotLineObject.h"

@interface InfoAppController : BaseCollectionController<UIAlertViewDelegate>{
    NSMutableArray *listSection;
    HotLineObject *hotLineItemSelected;
}

@end
