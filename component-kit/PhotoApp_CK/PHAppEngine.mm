//
//  AppEngine.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHAppEngine.h"

#import <UIKit/UIKit.h>

#import "PHViewController.h"

@interface PHAppEngine ()
@property (nonatomic, strong) UIWindow *window;
@end

@implementation PHAppEngine

+ (instancetype) appEngine
{
    return [[PHAppEngine alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

- (void)start
{
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[PHViewController viewController]];
    self.window.backgroundColor = [UIColor greenColor];
    [self.window makeKeyAndVisible];
}

@end
