//
//  ViewController.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHViewController.h"
#import <ComponentKit/ComponentKit.h>

@interface PHViewController ()

@end

@implementation PHViewController

+ (instancetype)viewController
{
    return [[PHViewController alloc] initWithNibName:nil
                                              bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
}


@end
