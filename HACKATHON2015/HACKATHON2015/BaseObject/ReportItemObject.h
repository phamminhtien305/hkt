//
//  ReportItemObject.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseObject.h"

@interface ReportItemObject : BaseObject

-(NSString *)getTitle;

-(NSString *)getDescription;

-(NSString *)getID;

-(NSDictionary *)getLocationDic;

-(float)getLatitude;

-(float)getLongtitude;

-(BOOL)shareWithPublic;

-(REPORT_STATE)state;

-(NSArray *)getImages;

-(NSString *)getFistImage;

@end
