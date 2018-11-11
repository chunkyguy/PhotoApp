//
//  PAPhoto.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAPhoto.h"

@interface PAPhoto ()

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *thumbURL;

@end

@implementation PAPhoto

+ (instancetype)photoWithJSON: (NSDictionary *) jsonDict;
{
    return [[PAPhoto alloc] initWithIdentifier:jsonDict[@"id"]
                                         title:jsonDict[@"title"]
                                           url:jsonDict[@"url"]
                                      thumbURL:jsonDict[@"thumbnailUrl"]];
}

- (instancetype)initWithIdentifier: (NSString *)aId title: (NSString *)aTitle url: (NSString *)aURL thumbURL: (NSString *)thumbURL;
{
    self = [super init];
    if (self) {
        _identifier = aId;
        _title = aTitle;
        _imageURL = [NSURL URLWithString:aURL];
        _thumbURL = [NSURL URLWithString:thumbURL];
    }
    return self;
}

- (NSURL *)imageURLWithResolution: (ImageResolution)resolution;
{
    switch (resolution) {
        case ImageResolutionThumbnail: return self.imageURL;
        case ImageResolutionFull: return self.thumbURL;
    }
}

@end
