//
//  PANetworkService.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PAPhoto;

@interface PANetworkService : NSObject

+ (void) getPhotoList: (void(^)(NSArray<PAPhoto *> * _Nullable photoList)) completion;

+ (void) getPhotoWithURL: (NSURL *)photoURL completion: (void(^)(UIImage * _Nullable image)) completion;

@end

NS_ASSUME_NONNULL_END
