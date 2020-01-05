//
//  PAImageLoader.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAImageLoader.h"
#import "PANetworkService.h"

@interface PAImageLoaderTask : NSObject
+ (instancetype)taskWithPhoto:(PAPhoto *)photo
               withResolution:(ImageResolution)resolution;
@property (nonatomic, readonly) PAPhoto *photo;
@property (nonatomic, readonly) ImageResolution resolution;
@end

@implementation PAImageLoaderTask
{
  PAPhoto *_photo;
  ImageResolution _resolution;
}

+ (instancetype)taskWithPhoto:(PAPhoto *)photo
               withResolution:(ImageResolution)resolution;
{
  return [[[self alloc] initWithPhoto:photo withResolution:resolution] autorelease];
}

- (instancetype)initWithPhoto:(PAPhoto *)photo
               withResolution:(ImageResolution)resolution;
{
  if(self = [super init]) {
    _photo = [photo retain];
    _resolution = resolution;
  }
  return self;
}

- (void)dealloc
{
  [_photo release];
  [super dealloc];
}
@end

@interface PAImageLoader () <PANetworkServiceDelegate>
{
  PANetworkService *_service;
  NSMutableDictionary *_tasks;
}

@property (nonatomic, retain) UIImage *image;
@end

@implementation PAImageLoader

+ (UIImage *)placehoderlmage
{
  return [UIImage imageNamed:@"placeholder"];
}

-(instancetype)init
{
  if (self = [super init]) {
    _service = [[PANetworkService alloc] init];
    _tasks = [[NSMutableDictionary alloc] init];
    [_service setDelegate:self];
  }
  return self;
}

- (void)dealloc
{
  [_tasks release];
  [_service release];
  [super dealloc];
}

- (void)loadPhoto: (PAPhoto *)photo resolution: (ImageResolution)resolution
{
  NSURL *photURL = [photo imageURLWithResolution:resolution];
  [_tasks setObject:[PAImageLoaderTask taskWithPhoto:photo withResolution:resolution] forKey:photURL];
  [_service getPhotoWithURL:photURL];
}

- (void)fetchPhotoURL:(NSURL *)photoURL
{
  [_tasks setObject:[NSNull null] forKey:photoURL];
  [_service getPhotoWithURL:photoURL];
}

#pragma mark - PANetworkServiceDelegate

- (void)networkService:(PANetworkService *)networkService didFetchPhoto:(UIImage *)image forURL:(NSURL *)photoURL
{
  dispatch_async(dispatch_get_main_queue(), ^{
    NSAssert(self.delegate != nil, @"No delegate");
    PAImageLoaderTask *task = [_tasks objectForKey:photoURL];
    [[task photo] setImage:image resolution:[task resolution]];
    [self.delegate imageLoader:self didLoadPhoto:[task photo]];
    [_tasks removeObjectForKey:photoURL];
  });
}

@end
