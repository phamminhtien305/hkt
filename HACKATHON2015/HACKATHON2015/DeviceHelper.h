//
//  DeviceHelper.h
//  AppComic
//
//  Created by Minh Tien on 11/3/14.
//  Copyright (c) 2014 Minh Tien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface DeviceHelper : NSObject
+ (BOOL) isDeviceIPad;

+ (BOOL) isDeviceIPhone;

+(CGSize)getWinSize;

+(CGRect)getWinFrame;

+ (NSString*) getDeviceID;

+(NSDictionary *)convertCLLocationToDegreesFormula:(CLLocation *)location;

+(NSString *)pathFile;

+(BOOL)checkExistsFileWithPath:(NSString *)filePath;

+(NSArray *)listPathArr:(NSString *)bundlePath;

+(int)countTheNumberOfFileInsideFolder:(NSString *)bundlePath;

+(NSString *)getPathComicWithComicID:(NSString *)comic_id;

+(NSString *)getPathChapterWithComicID:(NSString *)comic_id chapterID:(NSString *)chapter_id;

+(BOOL) deleteFile:(NSString*) path;

+(BOOL)Conecting3g;

+(BOOL)conectingWifi;

+(BOOL)detectInternet;

+(NSString *)sizeOfFolder:(NSString *)folderPath;

+(void)clearCache;

NSString * AFJSONStringFromParameters(NSDictionary *parameters);

@end
