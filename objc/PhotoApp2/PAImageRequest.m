//
//  PAImageRequest.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAImageRequest.h"
@interface PAImageRequest () {
    NSURL *_imageURL;
}

@end

@implementation PAImageRequest

+ (instancetype) requestWithURL:(NSURL *)requestURL
{
    return [[PAImageRequest alloc] initWithURL:requestURL];
}

- (instancetype)initWithURL:(NSURL *)aURL;
{
    self = [super init];
    if (self) {
        _imageURL = aURL;
    }
    return self;
}

- (NSURL *)requestURL
{
    return _imageURL;
}

@end
