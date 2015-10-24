//
//  BaseObject.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

static NSString * const ApplicationDictKey = @"dictionary";
static NSString * const ObjectStateKey = @"objectstate";

+ (NSArray*) createListDataFromListDict:(NSArray*) listDict {
    if (![listDict isKindOfClass:[NSArray class]])
        return nil;
    NSMutableArray *listData = [NSMutableArray array];
    int index = 0;
    for (NSDictionary* dict in listDict) {
        BaseObject *object = [[self alloc] initWithObjectDict:dict];
        [listData addObject:object];
        index ++;
    }
    return listData;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p> \"%@\"",
            [self class], self, self.objectDict];
}


- (void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.objectDict forKey:ApplicationDictKey];
    [coder encodeInt:self.objectState forKey:ObjectStateKey];
}

- (BOOL)requiresSecureCoding
{
    return YES;
}

- (void) updateObjectState {
    
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self) {
        self.objectDict = [coder decodeObjectForKey:ApplicationDictKey];
        self.objectState = [coder decodeIntForKey:ObjectStateKey];
    }
    return self;
}

- (id) initWithObjectDict:(NSDictionary*) applicationDict {
    self = [super init];
    if (self) {
        if (!applicationDict || ![applicationDict isKindOfClass:[NSDictionary class]]) {
            self.objectDict = [NSDictionary dictionary];
        }
        else
        {
            self.objectDict = applicationDict;
        }
        self.objectState = [self.objectDict objectForKey:@"error_code"] ? ![[self.objectDict objectForKey:@"error_code"] intValue] : YES;
    }
    return self;
}

- (id) objectForKey:(NSString*) key {
    return [self.objectDict objectForKey:key];
}

- (NSString*) getObjectMessage {
    return self.objectDict ? [self.objectDict objectForKey:@"message"] : nil;
}


@end
