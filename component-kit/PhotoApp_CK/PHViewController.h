//
//  ViewController.h
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PAImageDownloader;
@class PAPhoto;

@interface PHViewController : UIViewController

+ (instancetype)viewController;
- (void)onTap:(PAPhoto *)photo;

@property (readonly) PAImageDownloader *imageDownloader;
@end

