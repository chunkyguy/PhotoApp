//
//  PADetailViewController.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 28/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PAPhoto;
@class PAPhotoController;

@interface PADetailViewController : UIViewController
+ (instancetype)viewControllerWithPhoto:(PAPhoto *)photo controller:(PAPhotoController *)controller;
@end
