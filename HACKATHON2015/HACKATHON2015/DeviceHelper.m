//
//  DeviceHelper.m
//  AppComic
//
//  Created by Minh Tien on 11/3/14.
//  Copyright (c) 2014 Minh Tien. All rights reserved.
//

#import "DeviceHelper.h"
#import <UIKit/UIKit.h>
#import <AdSupport/ASIdentifierManager.h>
#import "OpenUDID.h"
#import "Reachability.h"
#import "AFJSONUtilities.h"
static NSString *AppotaAdsDeviceKey = @"appota_ads_device_appcomic_key";

@implementation DeviceHelper

+ (BOOL) isDeviceIPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
    NSString *deviceName = [UIDevice currentDevice].model;
    if ([deviceName rangeOfString:@"iPad"].location != NSNotFound ||
        [deviceName rangeOfString:@"ipad"].location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL) isDeviceIPhone {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
#endif
    NSString *deviceName = [UIDevice currentDevice].model;
    if ([deviceName rangeOfString:@"iPad"].location == NSNotFound &&
        [deviceName rangeOfString:@"ipad"].location == NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}


+(NSDictionary *)convertCLLocationToDegreesFormula:(CLLocation *)location{
    NSDictionary *result;
    int degrees = location.coordinate.latitude;
    double decimal = fabs(location.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];
    degrees = location.coordinate.longitude;
    decimal = fabs(location.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];
    
    result = [NSDictionary dictionaryWithObjectsAndKeys:
              lat,@"latitude",
              longt,@"longtitude", nil];
    
    return  result;
    
}



+(CGSize)getWinSize{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenRect.size;
    if(!DETECT_OS8){
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
            screenSize = CGSizeMake(screenSize.height, screenSize.width);
        }else{
             screenSize = CGSizeMake(screenSize.width, screenSize.height);
        }
    }
    return screenSize;
}

+(CGRect)getWinFrame{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect screenFrame = screenRect;
    if(!DETECT_OS8){
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
            screenFrame = CGRectMake(0, 0, screenRect.size.height, screenRect.size.width);
        }else{
            screenFrame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
        }
    }
    return screenFrame;
}

+ (NSString*) getDeviceID {
    NSString *openUDIDDevieKey = @"appota_open_udid_device_key";
    NSString *deviceID;
    
    if (DETECT_OS7) {
        if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
            deviceID = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
        }
    }
    else {
        NSString *defaultOpenUDIDKey = [[NSUserDefaults standardUserDefaults] objectForKey:openUDIDDevieKey];
        if (defaultOpenUDIDKey) {
            return defaultOpenUDIDKey;
        }
        else {
            deviceID = [OpenUDID value];
            [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:openUDIDDevieKey];
        }
    }
    if(!deviceID) {
        deviceID = [self getVendorUniqueString];
    }
    
    return deviceID;
}


+ (NSString*) getVendorUniqueString {
    NSString *deviceID;
    
    if (deviceID) {
        return deviceID;
    }
    if (NSClassFromString(@"ASIdentifierManager")) {
        if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
            deviceID = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            return deviceID;
        }
    }
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else {
        deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"appvn_cf_dv_id"];
        if (!deviceID) {
            CFUUIDRef udid = CFUUIDCreate(NULL);
            deviceID = (NSString *) CFBridgingRelease(CFUUIDCreateString(NULL, udid));
            CFRelease(udid);
            [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:@"appvn_cf_dv_id"];
        }
    }
    return deviceID;
}


+(NSString *)pathFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return (paths.count)? paths[0] : nil;
}

+(NSString *)getPathComicWithComicID:(NSString *)comic_id{
    NSString *filePath = [DeviceHelper pathFile];
    
    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@", comic_id]];
    
    return filePath;
}

+(NSString *)getPathChapterWithComicID:(NSString *)comic_id chapterID:(NSString *)chapter_id{
    NSString *filePath = [DeviceHelper pathFile];
    
    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@", comic_id]];

    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@",chapter_id]];
    
    return filePath;
}


+(BOOL)checkExistsFileWithPath:(NSString *)filePath{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+(int)countTheNumberOfFileInsideFolder:(NSString *)bundlePath{
    NSError *error = nil;
    
    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundlePath error:&error];
    
    int numberOfFileInFolder = (int)[directoryContent  count];
    
    return numberOfFileInFolder;
}


+(NSArray *)listPathArr:(NSString *)bundlePath{
    NSError *error = nil;
    NSArray *directoryContent  = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:bundlePath error:&error];
    NSMutableArray *result = [NSMutableArray new];
    for (NSString *objectAtIndex in directoryContent) {
        NSString *newPath = [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@",objectAtIndex]];
        [result addObject:newPath];
    }
    return result;
}

+(BOOL) deleteFile:(NSString*) path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *deleteErr = nil;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&deleteErr];
        if (deleteErr) {
            NSLog (@"Can't delete %@: %@", path, deleteErr);
            return NO;
        }
    }
    return YES;
}

+(BOOL)Conecting3g{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWWAN)
    {
        return YES;
    }
    return NO;
}

+(BOOL)conectingWifi{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == ReachableViaWiFi)
    {
        return YES;
    }
    return NO;
}

+(BOOL)detectInternet{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
        return NO;
    
    return YES;
}

+(NSString *)sizeOfFolder:(NSString *)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long int folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    
    //This line will give you formatted size from bytes ....
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}


+(void)clearCache{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *pathFolder = [DeviceHelper pathFile];
    
    pathFolder = [pathFolder stringByAppendingString:[NSString stringWithFormat:@"/cache"]];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:pathFolder error:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSString *filename in fileArray)  {
            NSError *deleteErr = nil;
            [[NSFileManager defaultManager] removeItemAtPath:[pathFolder stringByAppendingPathComponent:filename]  error:&deleteErr];
            if (deleteErr) {
                NSLog (@"Can't delete %@: %@", [pathFolder stringByAppendingPathComponent:filename], deleteErr);
            }else{
                NSLog (@"delete file %@", [pathFolder stringByAppendingPathComponent:filename]);
            }
        }
    });
}


NSString * AFJSONStringFromParameters(NSDictionary *parameters) {
    NSError *error = nil;
    NSData *JSONData = AFJSONEncode(parameters, &error);
    
    if (!error) {
        return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}


@end
