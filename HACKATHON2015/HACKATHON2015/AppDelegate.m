//
//  AppDelegate.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import "UploadEngine.h"
#import "PFController.h"
#import "ReportItemObject.h"
#import "NewsObject.h"
#import "ReportDetailViewController.h"
#import "UIAlertView+Blocks.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Branch.h"

@interface AppDelegate ()
{
}
@end

@implementation AppDelegate
+ (AppDelegate *)shareInstance{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initParse];
    
    [GMSServices provideAPIKey:GOOGLE_MAP_API_KEY];
    
    MainViewController *mainView = [MainViewController  shareMainViewController];
    
    self.window.rootViewController = mainView;
    
    [self.window setFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self handlePushWithDict:launchOptions];

    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    Branch *branch = [Branch getInstance];
    [branch initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary *params, NSError *error) {
        // params are the deep linked params associated with the link that the user clicked before showing up.
        NSLog(@"deep link data: %@", [params description]);
    }];
    return YES;
}

- (void) initParse {
    // Override point for customization after application launch.
    [Parse setApplicationId:PARSE_APP_ID
                  clientKey:PARSE_CLIENT_ID];
    // Register PFUser
    [PFController registerPFUserWithCompletionBlock:^(BOOL b) {
        [self registerAPN];        
    }];
}


-(void)registerAPN{
    UIApplication *application = [UIApplication sharedApplication];
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else {
        //Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    // Register Parse device token for setup push
    [self registerParseDeviceToken:devToken];
}


- (void) registerParseDeviceToken:(NSData*)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
    NSLog(@"Device token:%@",deviceToken);
    NSString* strdeviceToken = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    [[NSUserDefaults standardUserDefaults] setObject:strdeviceToken forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSArray *channels = currentInstallation.channels;
    for (NSString *channel in channels) {
        if ([channel rangeOfString:@"os_version"].location == 0 ||
            [channel rangeOfString:@"app_version"].location == 0 ||
            [channel rangeOfString:@"app_build"].location == 0) {
            [currentInstallation removeObject:channel forKey:@"channels"];
        }
    }
    PFUser *currUser = [PFUser currentUser];
    PFRelation *relation = [currentInstallation relationForKey:@"owner"];
    [relation addObject:currUser];
    [currentInstallation saveInBackground];
    
    [currentInstallation removeObjectForKey:@"device_name"];
    NSString *deviceName = [[UIDevice currentDevice] name];
    [currentInstallation addUniqueObject:deviceName forKey:@"device_name"];
    [currentInstallation saveInBackground];
    
    [currentInstallation removeObjectForKey:@"app_build"];
    [currentInstallation addUniqueObject:APP_BUILD_INDEX forKey:@"app_build"];
    [currentInstallation saveInBackground];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[Branch getInstance] handleDeepLink:url];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
    ];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    return [[Branch getInstance] continueUserActivity:userActivity];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    NSLog(@"Receive push %@", userInfo);
    [self handlePushWithDict:userInfo];
}

- (void) handlePushWithDict:(NSDictionary*) userInfo {
    NSLog(@"Receive push %@", userInfo);
    NSString *class = userInfo[@"class"];
    NSString *objectID = userInfo[@"objectId"];
    if (objectID) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Show alert");
            [UIAlertView showWithTitle:@"Có sự kiện mới"
                               message:userInfo[@"aps"][@"alert"]
                     cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"OK"] tapBlock:^(UIAlertView *  alertView, NSInteger buttonIndex) {
                         if (buttonIndex == 1) {
                             PFQuery *query = [PFQuery queryWithClassName:class];
                             [query getObjectInBackgroundWithId:objectID block:^(PFObject *object, NSError *error) {
                                 id vObject;
                                 if ([[object parseClassName] isEqual:@"News"]) {
                                     vObject = [[NewsObject alloc] initWithPFObject:object];
                                 }
                                 if ([[object parseClassName] isEqual:@"Report"]) {
                                     vObject = [[ReportItemObject alloc] initWithPFObject:object];
                                 }
                                 ReportDetailViewController *viewController = [[ReportDetailViewController alloc] initWithReportItem:vObject];
                                 [[MainViewController getRootNaviController] pushViewController:viewController animated:YES];
                             }];
                         }
                     }];
        });
    }
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hackathon.com.HACKATHON2015" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HACKATHON2015" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HACKATHON2015.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
