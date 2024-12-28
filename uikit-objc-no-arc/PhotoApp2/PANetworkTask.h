//
//  PANetworkTask.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PANetworkTask : NSObject

@property (nonatomic, readonly) NSURLSessionTask *sessionTask;
@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) NSURL *requestURL;

- (instancetype)initWithRequestURL:(NSURL *)requestURL;
- (void)resumeWithSession:(NSURLSession *)session;
- (void)appendData:(NSData *)data;

@end
