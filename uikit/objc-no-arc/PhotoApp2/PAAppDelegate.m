//
//  AppDelegate.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAAppDelegate.h"
#import "PAAppEngine.h"

@interface PAAppDelegate ()
{
  PAAppEngine *_appEngine;
}
@end

@implementation PAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  _appEngine = [[PAAppEngine alloc] init];
  [_appEngine start];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {
  [_appEngine release];
}

@end
