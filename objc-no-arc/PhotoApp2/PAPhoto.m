//
//  PAPhoto.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAPhoto.h"
#import "PAImageLoader.h"

@interface PAPhoto ()
{
  NSString *_identifier;
  NSString *_title;
  NSURL *_imageURL;
  NSURL *_thumbURL;
  NSMutableDictionary *_images;
}
@end

@implementation PAPhoto

+ (instancetype)photoWithJSON: (NSDictionary *) jsonDict;
{
  return [[[PAPhoto alloc] initWithIdentifier:jsonDict[@"id"]
                                        title:jsonDict[@"title"]
                                          url:jsonDict[@"url"]
                                     thumbURL:jsonDict[@"thumbnailUrl"]] autorelease];
}

- (instancetype)initWithIdentifier:(NSString *)aId
                             title:(NSString *)aTitle
                               url:(NSString *)aURL
                          thumbURL:(NSString *)thumbURL;
{
  self = [super init];
  if (!self) {
    return self;
  }
  _identifier = [aId copy];
  _title = [aTitle copy];
  _imageURL = [[NSURL alloc] initWithString:aURL];
  _thumbURL = [[NSURL alloc] initWithString:thumbURL];
  _images = [[NSMutableDictionary alloc] init];

  return self;
}

- (void)dealloc
{
  [_images release];
  [_identifier release];
  [_title release];
  [_imageURL release];
  [_thumbURL release];
  [super dealloc];
}

- (NSURL *)imageURLWithResolution:(ImageResolution)resolution;
{
  switch (resolution) {
    case ImageResolutionThumbnail:
      return _thumbURL;
      
    case ImageResolutionFull:
      return  _imageURL;
  }
}

- (UIImage *)imageWithResolution:(ImageResolution)resolution;
{
  UIImage *image = [_images objectForKey:[NSNumber numberWithInteger:resolution]];
  return image ?: [PAImageLoader placehoderlmage];
}

- (void)setImage:(UIImage *)image resolution:(ImageResolution)resolution;
{
  [_images setObject:image forKey:[NSNumber numberWithInteger:resolution]];
}

- (NSString *)identifier {
  return _identifier;
}

- (NSString *)title {
  return _title;
}

@end
