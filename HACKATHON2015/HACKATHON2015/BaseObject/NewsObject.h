//
//  NewsObject.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseObject.h"

@interface NewsObject : BaseObject

-(NSString *)getID;

-(NSString *)getTitle;

-(NSString *)getDescription;

-(id)getLocation;

-(REPORT_STATE)state;

-(NSArray *)getImages;

-(NSString*)getImage;

-(NSString*)getFirstImage;

-(float)getLatitude;

-(float)getLongtitude;

@end
