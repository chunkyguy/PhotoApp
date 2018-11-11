//
//  PHRootComponentProvider.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHRootComponentProvider.h"
#import <ComponentKit/ComponentKit.h>
#import "PAPhoto.h"
#import "PHViewController.h"
#import "PHLoadingComponent.h"
#import "PHPhotoComponent.h"

@implementation PHRootComponentProvider

+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context;
{
    if ([model isKindOfClass:[NSNull class]]) {
        return [PHRootComponentProvider loadingComponent];
    } else if ([model isKindOfClass:[PAPhoto class]]) {
        return [PHRootComponentProvider
                componentForPhoto:(PAPhoto *)model
                sender:(PHViewController *)context];
    } else {
        NSAssert(NO, @"Should not happen");
        return nil;
    }
}

+ (CKComponent *)loadingComponent
{
    return [PHLoadingComponent newWithTintColor:[UIColor redColor]];
}

+ (CKComponent *)componentForPhoto:(PAPhoto *)photo sender:(PHViewController *)sender;
{
    CKAction<UIGestureRecognizer *>action = CKAction<UIGestureRecognizer *>::actionFromBlock(^(CKComponent *, UIGestureRecognizer *__strong) {
        [sender onTap:photo];
    });

    return [PHPhotoComponent
            newWithPhoto:photo
            imageDownloader:sender.imageDownloader
            action: action];

}

@end
