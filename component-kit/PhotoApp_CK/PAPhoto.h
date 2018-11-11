//
//  PAPhoto.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ImageResolution) {
    ImageResolutionThumbnail,
    ImageResolutionFull
};

@interface PAPhoto : NSObject

+ (instancetype)photoWithJSON: (NSDictionary *) jsonDict;
- (instancetype)initWithIdentifier: (NSString *)aId title: (NSString *)aTitle url: (NSURL *)aURL thumbURL: (NSURL *)thumbURL;

- (NSURL *)imageURLWithResolution: (ImageResolution)resolution;

@property (readonly) NSString *identifier;
@property (readonly) NSString *title;

@end

NS_ASSUME_NONNULL_END
