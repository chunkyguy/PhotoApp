//
//  PAImageLoader.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PAPhoto.h"
NS_ASSUME_NONNULL_BEGIN

@interface PAImageLoader : NSObject

+ (UIImage *)placeholderImage;
+ (void)loadPhoto: (PAPhoto *)photo resolution: (ImageResolution)resolution completion: (void(^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
