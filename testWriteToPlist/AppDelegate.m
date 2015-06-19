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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self testReadNSStringOfUserData];
    [self testWriteNSStringOfUserData];
    [self testReadNSStringOfUserData];

    [self testReadNSStringOfNorthNormalTrain];
    [self testWriteNSStringOfNorthNormalTrain];
    [self testReadNSStringOfNorthNormalTrain];
    return YES;
}

- (void)testReadNSStringOfUserData {
    [self readAllFromMyPlist:@"UserData" key:[[NSArray alloc]initWithObjects:@"sTest", nil] object:nil];
}

- (void)testReadNSStringOfNorthNormalTrain {
    [self readAllFromMyPlist:@"NorthNormalTrain" key:[[NSArray alloc]initWithObjects:@"sTest", nil] object:nil];
}

- (void)testWriteNSStringOfUserData {
    [self writeAllToMyPlist:@"UserData" value:[[NSArray alloc]initWithObjects:@"v_sTest_new_UserData_24", nil]key:[[NSArray alloc]initWithObjects:@"sTest", nil]];
}

- (void)testWriteNSStringOfNorthNormalTrain {
    [self writeAllToMyPlist:@"NorthNormalTrain" value:[[NSArray alloc]initWithObjects:@"v_sTest_new_North_24", nil]key:[[NSArray alloc]initWithObjects:@"sTest", nil]];
}

//[[Plist
//- (void)writeAllToMyPlist
//{
//    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
//    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
//    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
//        [nsfmPlistFileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] toPath:nssPlistDst error:nil];
//    }
//    nsfmPlistFileManager = nil;
//    
//    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
//    [nsmdPlistDictionary setValue:@"v_sTest_new_17" forKey:@"sTest"];
//    [nsmdPlistDictionary writeToFile:nssPlistDst atomically:YES];
//    nsmdPlistDictionary = nil;
//}
//
//- (void)readAllFromMyPlist
//{
//    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
//    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
//    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
//        [nsfmPlistFileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"] toPath:nssPlistDst error:nil];
//    }
//    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
//    if (nsmdPlistDictionary != nil) {
//        NSLog(@"readAllFromMyPlist: %@", [nsmdPlistDictionary objectForKey:@"sTest"]);
//    }
//    nsfmPlistFileManager = nil;
//    nssPlistDst = nil;
//}

- (void)writeAllToMyPlist:(NSString *)nssFileName value:(NSArray *)nsaValue key:(NSArray *)nsaKey
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/%@.plist", NSHomeDirectory(), nssFileName];
    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:nssFileName ofType:@"plist"] toPath:nssPlistDst error:nil];
    }
    nsfmPlistFileManager = nil;
    
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
    for (NSInteger nsiIndex = 0; nsiIndex < [nsaKey count]; nsiIndex++) {
        [nsmdPlistDictionary setValue:[nsaValue objectAtIndex:nsiIndex] forKey:[nsaKey objectAtIndex:nsiIndex]];
    }
    [nsmdPlistDictionary writeToFile:nssPlistDst atomically:YES];
    nsmdPlistDictionary = nil;
}

- (void)readAllFromMyPlist:(NSString *)nssFileName key:(NSArray *)nsaKey object:(id)idObject
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistDst = [NSString stringWithFormat:@"%@/Documents/%@.plist", NSHomeDirectory(), nssFileName];
    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:nssFileName ofType:@"plist"] toPath:nssPlistDst error:nil];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:nssPlistDst];
    if (nsmdPlistDictionary != nil) {
        for (NSInteger nsiIndex = 0; nsiIndex < [nsaKey count]; nsiIndex++) {
            NSLog(@"readAllFromMyPlist: %@", [nsmdPlistDictionary objectForKey:[nsaKey objectAtIndex:nsiIndex]]);
            idObject = [nsmdPlistDictionary objectForKey:[nsaKey objectAtIndex:nsiIndex]];
        }
    }
    nsfmPlistFileManager = nil;
    nssPlistDst = nil;
}
//]]Plist

@end
