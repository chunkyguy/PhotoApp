//
//  AppEngine.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAAppEngine.h"
#import "PAPhotoController.h"
#import "PAListViewController.h"
#import "UINavigationBar+Decoration.h"


@interface PAAppEngine ()
{
  UIWindow *_window;
}
@end

@implementation PAAppEngine

- (instancetype)init
{
  self = [super init];
  if (!self) {
    return nil;
  }

  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  return self;
}

- (void)dealloc
{
  [_window release];
  [super dealloc];
}

- (void)start
{
  [_window setBackgroundColor:[UIColor greenColor]];
  [_window makeKeyAndVisible];

  UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[PAListViewController listViewControllertWithController:[PAPhotoController controller]]];
  [[rootViewController navigationBar] decorate];
  [_window setRootViewController:rootViewController];
}
@end


