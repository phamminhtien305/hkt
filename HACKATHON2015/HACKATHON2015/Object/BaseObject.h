//
//  BaseObject.h
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject

@property (readwrite) BOOL objectState;
@property (nonatomic, copy) NSDictionary* objectDict;
- (NSString*)description;
- (id) initWithObjectDict:(NSDictionary*) applicationDict;
+ (NSArray*) createListDataFromListDict:(NSArray*) listDict;
- (id) objectForKey:(NSString*) key;
- (NSString*) getObjectMessage;


@end
