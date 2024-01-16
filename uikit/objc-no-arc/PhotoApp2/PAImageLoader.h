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

@protocol PAImageLoaderDelegate;

@interface PAImageLoader : NSObject

+ (UIImage *)placehoderlmage;

- (void)loadPhoto:(PAPhoto *)photo
       resolution:(ImageResolution)resolution;


@property (nonatomic, assign) id<PAImageLoaderDelegate> delegate;
@end

@protocol PAImageLoaderDelegate <NSObject>

- (void)imageLoader:(PAImageLoader *)imageLoader didLoadPhoto:(PAPhoto *)photo;

@end
