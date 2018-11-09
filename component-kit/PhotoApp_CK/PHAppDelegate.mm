//
//  AppDelegate.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHAppDelegate.h"
#import "PHAppEngine.h"

@interface PHAppDelegate ()
@property (nonatomic, strong) PHAppEngine *appEngine;
@end

@implementation PHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.appEngine = [PHAppEngine appEngine];
    [self.appEngine start];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{}

- (void)applicationDidEnterBackground:(UIApplication *)application
{}

- (void)applicationWillEnterForeground:(UIApplication *)application
{}

- (void)applicationDidBecomeActive:(UIApplication *)application
{}

- (void)applicationWillTerminate:(UIApplication *)application
{}

@end
