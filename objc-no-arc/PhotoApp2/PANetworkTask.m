//
//  PANetworkTask.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PANetworkTask.h"

@interface PANetworkTask ()
{
  NSURL *_requestURL;
  NSURLSessionTask *_sessionTask;
  NSMutableData *_data;
}
@end

@implementation PANetworkTask

- (instancetype)initWithRequestURL:(NSURL *)requestURL;
{
  if (self = [super init]) {
    _requestURL = [requestURL copy];
    _data = [[NSMutableData alloc] init];
  }
  return self;
}

- (void)resumeWithSession:(NSURLSession *)session;
{
  _sessionTask = [[session dataTaskWithURL:_requestURL] retain];
  [_sessionTask resume];
}

- (void)appendData:(NSData *)data
{
  [_data appendData:data];
}

- (void)dealloc
{
  [_requestURL release];
  [_sessionTask release];
  [_data release];
  [super dealloc];
}

@end
