//
//  AppDelegate.m
//  testWriteToPlist
//
//  Created by lololol on 18/Jun/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)popup:(NSString *)nssTitle message:(NSString *)nssMessage {
    [[[UIAlertView alloc] initWithTitle:nssTitle
                                                    message:nssMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil] show];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self testReadNSStringOfUserData];
//    [self testReadNSArrayOfUserData];
//    [self testReadNSStringOfNorthNormalTrain];
    
//    [self testWriteNSStringOfUserData];
//    [self testWriteNSArrayOfUserData];
//    [self testWriteNSStringOfNorthNormalTrain];
    
//    [self testReadNSStringOfUserData];
//    [self testReadNSArrayOfUserData];
//    [self testReadNSStringOfNorthNormalTrain];
    [self readAllFromMyPlist];
    [self writeAllToMyPlist];
    [self readAllFromMyPlist];
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "me.leisureapp.testWriteToPlist" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"testWriteToPlist" withExtension:@"momd"];
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
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"testWriteToPlist.sqlite"];
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

- (void)testReadNSStringOfUserData {
    NSDictionary *nsdPlistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"]];
    if (nsdPlistDictionary != nil) {
        [self popup:@"sTest" message:[nsdPlistDictionary objectForKey:@"sTest"]];
        NSLog(@"%@", [nsdPlistDictionary objectForKey:@"sTest"]);
    } else {
        NSLog(@"bug");
    }
    nsdPlistDictionary = nil;
}

- (void)testReadNSArrayOfUserData {
    NSDictionary *nsdPlistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"]];
    if (nsdPlistDictionary != nil) {
        [self popup:@"aTest" message:[NSString stringWithFormat:@"%ld", (long)[[nsdPlistDictionary objectForKey:@"aTest"]count]]];
    }
    nsdPlistDictionary = nil;
}

- (void)testReadNSStringOfNorthNormalTrain {
    NSDictionary *nsdPlistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"]];
    if (nsdPlistDictionary != nil) {
        [self popup:@"NorthNormalTrain" message:[NSString stringWithFormat:@"%ld", (long)[[nsdPlistDictionary objectForKey:@"NorthNormalTrain"]count]]];
    }
    nsdPlistDictionary = nil;
}

- (void)writeToMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:nssPlistSrc toPath:nssPlistDst error:nil];
    }
    nsfmPlistFileManager = nil;
    nssPlistSrc = nil;

    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
    [nsmdPlistDictionary setValue:@"v_sTest_new" forKey:@"sTest"];
    [nsmdPlistDictionary writeToFile:nssPlistDst atomically:YES];
    nsmdPlistDictionary = nil;
}

- (void)testWriteNSStringOfUserData {
//    NSDictionary *nsdPlistDictionary = [NSDictionary new];
//    [self popup:@"sTest before write" message:[nsmdPlistDictionary objectForKey:@"sTest"]];
//    [self popup:@"sTest after write" message:[nsmdPlistDictionary objectForKey:@"sTest"]];
//    NSLog(@"%d", [nsmdPlistDictionary writeToFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] atomically:YES]);
//    NSLog(@"%d", [@"abcde" writeToFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] atomically:YES]);
//    nsmdPlistDictionary = nil;

//    [[[NSDictionary alloc]initWithObjects:[[NSArray alloc]initWithObjects:@"v_sTest_new",nil] forKeys:[[NSArray alloc]initWithObjects:@"sTest",nil]] writeToFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] atomically:YES];

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    NSString *photoCacheFilename = [documentsPath stringByAppendingPathComponent:@"UserData"];
//    [[[[NSDictionary alloc]initWithObjects:[[NSArray alloc]initWithObjects:@"v_sTest_new",nil]
//                                  forKeys:[[NSArray alloc]initWithObjects:@"sTest",nil]]] writeToFile:photoCacheFilename atomically:YES];
    
//    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
//    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
//    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
//    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
//        [nsfmPlistFileManager copyItemAtPath:nssPlistSrc toPath:nssPlistDst error:nil];
//    }
//    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
//    [nsmdPlistDictionary setValue:@"v_sTest_new" forKey:@"sTest"];
//    NSLog(@"%hhd", [nsmdPlistDictionary writeToFile:nssPlistDst atomically:YES]);
//    nsmdPlistDictionary = nil;
//    [self testReadNSStringOfUserData];
    
    [self writeToMyPlist];
}

- (void)testWriteNSArrayOfUserData {
    NSMutableDictionary *nsmdPlistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"]];
    [[nsmdPlistDictionary objectForKey:@"aTest"]addObject:@"v_aTest3"];
    [nsmdPlistDictionary writeToFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] atomically:YES];
    nsmdPlistDictionary = nil;
}

- (void)testWriteNSStringOfNorthNormalTrain {
    NSMutableDictionary *nsmdPlistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"]];
    [[nsmdPlistDictionary objectForKey:@"NorthNormalTrain"]addObject:[[NSDictionary alloc]initWithObjects:[[NSArray alloc]initWithObjects:@"1001", @"10:50", nil] forKeys:[[NSArray alloc]initWithObjects:@"sStation", @"sARRTime", nil]]];
    [nsmdPlistDictionary writeToFile:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] atomically:YES];
    nsmdPlistDictionary = nil;
}

- (NSString *)dataFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"UserData.plist"];
}

- (void)writePlist
{
    NSMutableArray *anArray = [[NSMutableArray alloc]init];
    [anArray addObject:@"Milmers"];
    [anArray addObject:@"Xcode"];
    [anArray writeToFile:[self dataFilePath] atomically:YES];
}

- (void)readPlist
{
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        NSLog(@"%@\n", array);
        NSLog(@"%@\n", filePath);
    }
}

//[[Plist
- (void)initMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
    _nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:_nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:nssPlistSrc toPath:_nssPlistDst error:nil];
    }
    nsfmPlistFileManager = nil;
    nssPlistSrc = nil;
}

- (void)writeAllToMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] toPath:nssPlistDst error:nil];
    }
    nsfmPlistFileManager = nil;
    
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
    [nsmdPlistDictionary setValue:@"v_sTest_new_17" forKey:@"sTest"];
    [nsmdPlistDictionary writeToFile:nssPlistDst atomically:YES];
    nsmdPlistDictionary = nil;
}

- (void)readAllFromMyPlist {;
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] toPath:nssPlistDst error:nil];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
    if (nsmdPlistDictionary != nil) {
        NSLog(@"readAllFromMyPlist: %@", [nsmdPlistDictionary objectForKey:@"sTest"]);
    }
    nsfmPlistFileManager = nil;
    nssPlistDst = nil;
}
//]]Plist

@end
