//
//  PANetworkService.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PANetworkService.h"

#import "PAPhoto.h"
#import "PAPhotoListTask.h"
#import "PAPhotoTask.h"

@interface PANetworkService () <NSURLSessionDataDelegate>
{
  NSURLSession *_session;
  NSMutableArray *_tasks;
}
@end

@implementation PANetworkService

- (instancetype)init
{
  if (self = [super init]) {
    _session = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                              delegate:self
                                         delegateQueue:nil] retain];
    _tasks = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)dealloc
{
  [_session release];
  [_tasks release];
  [super dealloc];
}

- (void)getPhotoList
{
  [self getDataWithRequest:[PAPhotoListTask request]];
}

- (void)getPhotoWithURL:(NSURL *)photoURL
{
  [self getDataWithRequest:[PAPhotoTask requestWithURL:photoURL]];
}

#pragma mark - Private

- (void)getDataWithRequest:(PANetworkTask *)task
{
  [_tasks addObject:task];
  [task resumeWithSession:_session];
}

- (PANetworkTask *)taskWithSessionTask:(NSURLSessionTask *)aTask
{
  for (PANetworkTask *task in _tasks) {
    if ([task sessionTask] == aTask) {
      return task;
    }
  }
  return nil;
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
  [[self taskWithSessionTask:dataTask] appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error
{
  NSAssert(self.delegate != nil, @"No delegate set");
  PANetworkTask *networkTask = [self taskWithSessionTask:task];
  if ([networkTask isKindOfClass:[PAPhotoListTask class]] && [self.delegate respondsToSelector:@selector(networkService:didFetchPhotoList:)]) {
    [self.delegate networkService:self didFetchPhotoList:[(PAPhotoListTask *)networkTask photoList]];
  } else if ([networkTask isKindOfClass:[PAPhotoTask class]] && [self.delegate respondsToSelector:@selector(networkService:didFetchPhoto:forURL:)]) {
    [self.delegate networkService:self didFetchPhoto:[(PAPhotoTask *)networkTask photo] forURL:[networkTask requestURL]];
  } else {
    NSLog(@"Unhandled case");
  }
}
@end
