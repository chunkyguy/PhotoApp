//
//  AppEngine.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAAppEngine.h"
#import "PAListViewModel.h"
#import "PAListViewController.h"

@interface PAAppEngine ()
@property (strong, nonatomic) UIWindow *window;
- (void)decorateNavigationBar:(UINavigationBar *)navBar;
@end

@implementation PAAppEngine

+ (instancetype)engine
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    PAAppEngine *engine = [[PAAppEngine alloc] initWithWindow:window];
    [window setBackgroundColor:[UIColor greenColor]];
    [window makeKeyAndVisible];
    return engine;
}

- (instancetype)initWithWindow: (UIWindow *)aWindow;
{
    self = [super init];
    if (!self) {
        return nil;
    }

    self.window = aWindow;
    PAListViewModel *viewModel = [[PAListViewModel alloc] init];
    PAListViewController *listViewController = [[PAListViewController alloc] initWithDelegate:viewModel];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:listViewController];
    [self decorateNavigationBar:rootViewController.navigationBar];
    [aWindow setRootViewController:rootViewController];

    return self;
}

- (void)decorateNavigationBar:(UINavigationBar *)navBar;
{
    navBar.translucent = YES;
    navBar.prefersLargeTitles = NO;
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

@end
