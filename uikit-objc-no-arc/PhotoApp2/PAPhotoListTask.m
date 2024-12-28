//
//  PAPhotoListTask.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAPhotoListTask.h"
#import "PAPhoto.h"

@implementation PAPhotoListTask

+ (instancetype)request
{
  return [[[self alloc] initWithRequestURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/photos"]] autorelease];
}

- (NSArray *)photoList
{
  if ([self data] == nil) {
    return nil;
  }

  NSError *error = nil;
  id jsonData = [NSJSONSerialization JSONObjectWithData:[self data]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
  if (error != nil || ![jsonData isKindOfClass:[NSArray class]]) {
    return nil;
  }

  NSArray *photoListJSON = jsonData;
  NSMutableArray *photoList = [NSMutableArray array];
  for (NSDictionary *photoJSON in photoListJSON) {
    [photoList addObject:[PAPhoto photoWithJSON:photoJSON]];
  }
  return photoList;
}

@end
