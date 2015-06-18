//
//  AppDelegate.h
//  testWriteToPlist
//
//  Created by lololol on 18/Jun/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *nssPlistDst;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)testWriteNSStringOfUserData;
- (void)testReadNSStringOfUserData;

- (void)writePlist;
- (void)readPlist;

@end

