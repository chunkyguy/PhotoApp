//
//  PAImageLoader.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAImageLoader.h"
#import "PANetworkService.h"

@implementation PAImageLoader

+ (UIImage *)placeholderImage
{
    return [UIImage imageNamed:@"placeholder"];
}

+ (void)loadPhoto: (PAPhoto *)photo resolution: (ImageResolution)resolution completion: (void(^)(UIImage *))completion;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PANetworkService getPhotoWithURL:[photo imageURLWithResolution:resolution] completion:^(UIImage * _Nullable image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }];
    });
}

@end
