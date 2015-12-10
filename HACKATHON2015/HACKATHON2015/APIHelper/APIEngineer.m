//
//  APIEngineer.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "APIEngineer.h"
#import "APIConfig.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppConfig.h"
#import <JSONKit/JSONKit.h>
#import "DeviceHelper.h"

@implementation APIEngineer
+ (APIEngineer*) sharedInstance{
    static APIEngineer *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[APIEngineer alloc] initWithBaseURL:[NSURL URLWithString:AF_API_HOST]];
    });
    return sharedInstance;
}

+ (NSString *)replaceTokenString:(NSString *)str {
    return str;
}

#pragma mark - Request
- (void)requestParseWithLink:(NSString*)link
           withCompleteBlock:(AppResultCompleteBlock)completeBlock
                  errorBlock:(AppResultErrorBlock)errorBlock{
    
    NSString *path=[APIEngineer replaceTokenString:link];
    NSMutableDictionary *paramWillSend = [[NSMutableDictionary alloc] init];
    
    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [self.requestSerializer setValue:PARSE_APP_ID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [self.requestSerializer setValue:PARSE_REST_API_ID forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self GET:path parameters:paramWillSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dictResponse = (NSMutableDictionary*)responseObject;
        if (dictResponse && [dictResponse objectForKey:@"results"]) {
            if (![[dictResponse objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
                completeBlock([responseObject objectForKey:@"results"],NO);
            } else {
                NSLog(@"errorCode = NULL");
            }
        } else {
            NSLog(@"responseObject: %@", responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        errorBlock(error);
    }];
}


-(void)postMessageToPage:(NSString *)link
              withParams:(NSDictionary *)params
       withCompleteBlock:(AppResultCompleteBlock)completeBlock
              errorBlock:(AppResultErrorBlock)errorBlock
{
    [self POST:link parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void) objectFromJSonString:(NSString*) jsonString
          withCompletionBlock:(void (^)(id jsonObject)) jsonDecompressionHandler{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (![jsonString isKindOfClass:[NSString class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                jsonDecompressionHandler(jsonString);
            });
            return;
        }
        id jsonObject = [jsonString objectFromJSONString];
        if (!jsonObject) {
            jsonDecompressionHandler(nil);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            jsonDecompressionHandler([self handleAPICompletionData:jsonObject]);
        });
    });
}


- (id) handleAPICompletionData:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *newData = [NSMutableDictionary dictionaryWithDictionary:data];
        for (id key in [data allKeys]) {
            id value = [newData objectForKey:key];
            if ([value isKindOfClass:[NSNull class]])
                [newData removeObjectForKey:key];
            else
                [newData setObject:[self handleAPICompletionData:value] forKey:key];
        }
        return newData;
    } else if ([data isKindOfClass:[NSArray class]]) {
        NSMutableArray *newArray = [NSMutableArray arrayWithArray:data];
        for (int index = 0; index<newArray.count; index++) {
            id item = newArray[index];
            newArray[index] = [self handleAPICompletionData:item];
        }
        return newArray;
    }
    
    return data;
}



@end
