//
//  PHDetailViewController.h
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PAPhoto;
@class PAImageDownloader;

@interface PHDetailViewController : UIViewController
+ (instancetype)viewControlerWithPhoto:(PAPhoto *)photo imageDownloader:(PAImageDownloader *)imageDownloader;
@end

NS_ASSUME_NONNULL_END
