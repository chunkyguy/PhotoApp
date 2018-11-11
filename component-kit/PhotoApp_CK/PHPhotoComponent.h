//
//  PHPhotoComponent.h
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PAPhoto;
@class PAImageDownloader;

@interface PHPhotoComponent : CKCompositeComponent
+ (instancetype)newWithPhoto:(PAPhoto *)photo
             imageDownloader:(PAImageDownloader *)imageDownloader
                      action:(const CKAction<UIGestureRecognizer *> &)action;
@end

NS_ASSUME_NONNULL_END
