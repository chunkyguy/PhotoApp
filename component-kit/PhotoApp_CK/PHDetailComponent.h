//
//  PHDetailComponent.h
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PAPhoto;
@class PAImageDownloader;

@interface PHDetailComponent : CKCompositeComponent
+ (instancetype)newWithPhoto:(PAPhoto *)photo
             imageDownloader:(PAImageDownloader *)imageDownloader;
@end

NS_ASSUME_NONNULL_END
