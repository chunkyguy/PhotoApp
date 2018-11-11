//
//  PAImageDownloader.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAImageDownloader.h"
#import "PANetworkService.h"

@implementation PAImageDownloader
- (id)downloadImageWithURL:(NSURL *)URL
                    caller:(id)caller
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError *error))completion;
{
    [PANetworkService getPhotoWithURL:URL completion:^(UIImage * _Nullable image) {
        dispatch_async(callbackQueue, ^{
            if (image == nil) {
                completion(nil, [NSError
                                 errorWithDomain:@"com.wl.error.image"
                                 code:0
                                 userInfo:nil]);
            } else {
                completion(image.CGImage, nil);
            }
        });
    }];
    return [URL absoluteString];
}

- (void)cancelImageDownload:(id)download;
{}
@end
