//
//  PHLoadingComponent.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 10/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHLoadingComponent.h"

@implementation PHLoadingComponent

+ (instancetype)newWithTintColor:(UIColor *)color
{
    CKComponentViewConfiguration config;
    CKComponent *spinnerComponent = [CKComponent
                                     newWithView:{
                                         [UIActivityIndicatorView class],
                                         {
                                             {@selector(setColor:), color},
                                             {@selector(setActivityIndicatorViewStyle:), UIActivityIndicatorViewStyleWhiteLarge},
                                             {@selector(startAnimating), nil}
                                         }
                                     }
                                     size: CKComponentSize::fromCGSize([UIScreen mainScreen].bounds.size)];

    return [super newWithComponent: spinnerComponent];
}

@end

