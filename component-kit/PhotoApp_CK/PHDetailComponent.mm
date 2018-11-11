//
//  PHDetailComponent.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHDetailComponent.h"
#import "PAPhoto.h"
#import "PHPhotoComponent.h"

@implementation PHDetailComponent
+ (instancetype)newWithPhoto:(PAPhoto *)photo
             imageDownloader:(PAImageDownloader *)imageDownloader
{
    CKComponent *photoComponent = [PHPhotoComponent newWithPhoto:photo imageDownloader:imageDownloader action:{}];
    return [super newWithComponent:photoComponent];
}
@end
