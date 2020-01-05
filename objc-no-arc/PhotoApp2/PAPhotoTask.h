//
//  PAPhotoTask.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PANetworkTask.h"
#import <UIKit/UIKit.h>

@interface PAPhotoTask : PANetworkTask

+ (instancetype)requestWithURL:(NSURL *)requestURL;
- (UIImage *)photo;
@end
