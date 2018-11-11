//
//  PHPhotoComponent.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHPhotoComponent.h"
#import "PAPhoto.h"
#import "PAImageDownloader.h"
#import "PAImageLoader.h"

@implementation PHPhotoComponent
+ (instancetype)newWithPhoto:(PAPhoto *)photo
             imageDownloader:(PAImageDownloader *)imageDownloader
                      action:(const CKAction<UIGestureRecognizer *> &)action
{
    UIImage *placeholderImage = [PAImageLoader placeholderImage];
    CKComponentSize size = CKComponentSize::fromCGSize(placeholderImage.size);
    CKComponent *imageComponent = [CKNetworkImageComponent
                                   newWithURL:[photo imageURLWithResolution:ImageResolutionThumbnail]
                                   imageDownloader:imageDownloader
                                   size:size
                                   options:{ .defaultImage = placeholderImage }
                                   attributes:{}];

    CKComponent *centerYComponent = [CKCenterLayoutComponent
                                     newWithCenteringOptions:CKCenterLayoutComponentCenteringY
                                     sizingOptions:CKCenterLayoutComponentSizingOptionMinimumY
                                     child:imageComponent
                                     size:{}];

    CKComponent *containerComponent = [CKFlexboxComponent
                                       newWithView:{
                                           [UIView class],
                                           {CKComponentTapGestureAttribute(action)}
                                       }
                                       size:{}
                                       style:{}
                                       children:{
                                           {centerYComponent}
                                       }];

    return [super newWithComponent:containerComponent];
}
@end
