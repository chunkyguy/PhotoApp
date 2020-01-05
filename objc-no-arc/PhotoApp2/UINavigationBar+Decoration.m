//
// Created by Sidharth Juyal on 26/12/2019.
// Copyright © 2019 Sidharth Juyal. All rights reserved.
// 

#import "UINavigationBar+Decoration.h"
#import <UIKit/UIKit.h>


@implementation UINavigationBar (Decoration)

- (void)decorate
{
  [self setTranslucent:YES];
  [self setPrefersLargeTitles:NO];
  [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

@end
