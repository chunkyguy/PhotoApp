//
//  PAPhotoController.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAPhotoController.h"
#import "PAPhoto.h"
#import "PANetworkService.h"
#import "PAImageLoader.h"

@interface PAPhotoController () <PANetworkServiceDelegate, PAImageLoaderDelegate>
{
  PANetworkService *_networkService;
  PAImageLoader *_imageLoader;
}
@property (nonatomic, retain) NSArray *photoList;
@end

@implementation PAPhotoController

+ (instancetype)controller
{
  return [[[self alloc] init] autorelease];
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _imageLoader = [[PAImageLoader alloc] init];
    _networkService = [[PANetworkService alloc] init];
    _photoList = [[NSArray alloc] init];

    [_networkService setDelegate:self];
    [_imageLoader setDelegate:self];
  }
  return self;
}

- (void)dealloc
{
  [_imageLoader release];
  [_networkService release];
  [_photoList release];
  [super dealloc];
}

- (void)loadPhotoList
{
  [_networkService getPhotoList];
}

- (void)loadPhoto:(PAPhoto *)photo withResolution:(ImageResolution)resolution
{
  [_imageLoader loadPhoto:photo resolution:resolution];
}

- (PAPhoto *)itemAtIndex:(NSInteger)index
{
  NSAssert(index < [_photoList count], @"out of bounds");
  return [_photoList objectAtIndex:index];
}

- (NSInteger)totalItems
{
  return [_photoList count];
}

#pragma mark - PANetworkServiceDelegate
- (void)networkService:(PANetworkService *)networkService didFetchPhotoList:(NSArray *)photoList;
{
  self.photoList = photoList;
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.delegate listController:self didFetchListWithSuccess:photoList != nil];
  });
}

#pragma mark - PAImageLoaderDelegate
- (void)imageLoader:(PAImageLoader *)imageLoader didLoadPhoto:(PAPhoto *)photo
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.delegate listController:self didFetchPhoto:photo];
  });
}
@end
