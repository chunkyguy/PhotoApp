//
//  PAPhotoTask.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAPhotoTask.h"

@implementation PAPhotoTask

+ (instancetype)requestWithURL:(NSURL *)requestURL
{
  return [[[self alloc] initWithRequestURL:requestURL] autorelease];
}

- (UIImage *)photo
{
  if ([self data] != nil) {
    return [UIImage imageWithData:[self data]];
  } else {
    return nil;
  }
}

@end
