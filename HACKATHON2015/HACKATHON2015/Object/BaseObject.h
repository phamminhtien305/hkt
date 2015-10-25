//
//  BaseObject.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BaseObject : NSObject

@property (readwrite) BOOL objectState;
@property int order;
@property (nonatomic, strong) PFObject * pfObject;
- (NSString*)description;
- (id) initWithPFObject:(PFObject*) pfItem;
+ (NSArray*) createListDataFromPFObject:(NSArray*) listPFObject;
- (id) objectForKey:(NSString*) key;
- (NSString*) getObjectMessage;
-(NSString *)createDate;
-(NSString *)updateTime;

@end
