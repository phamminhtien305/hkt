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

+ (NSArray*) createListDataFromPFObject:(NSArray*) listPFObject {
    if (![listPFObject isKindOfClass:[NSArray class]])
        return nil;
    NSMutableArray *listData = [NSMutableArray array];
    int index = 0;
    for (PFObject* pfobject in listPFObject) {
        BaseObject *object = [[self alloc] initWithPFObject:pfobject];
        object.order = index;
        [listData addObject:object];
        index ++;
    }
    return listData;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p> \"%@\"",
            [self class], self, self.pfObject];
}


- (void) encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.pfObject forKey:ApplicationDictKey];
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
        self.pfObject = [coder decodeObjectForKey:ApplicationDictKey];
        self.objectState = [coder decodeIntForKey:ObjectStateKey];
    }
    return self;
}


- (id) initWithPFObject:(PFObject*) pfItem{
    self = [super init];
    if (self) {
        if (pfItem && [pfItem isKindOfClass:[PFObject class]]) {
            self.pfObject = pfItem;
        }
    }
    return self;
}

- (id) objectForKey:(NSString*) key {
    return [self.pfObject objectForKey:key];
}

- (NSString*) getObjectMessage {
    return self.pfObject ? [self.pfObject objectForKey:@"message"] : nil;
}


-(NSString *)createDate{
    if(self.pfObject){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
        [dateFormatter setDateFormat: @"dd/MM/yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:self.pfObject.createdAt];
        return strDate;
    }
    return @"";
}

-(NSString *)updateTime{
    if(self.pfObject){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
        [dateFormatter setDateFormat: @"dd/MM/yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:self.pfObject.updatedAt];
        return strDate;
    }
    return @"";
}
@end
