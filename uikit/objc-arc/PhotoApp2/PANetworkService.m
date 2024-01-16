//
//  PANetworkService.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PANetworkService.h"
#import "PANetworkRequest.h"
#import "PAPhotoListReqeust.h"
#import "PAImageRequest.h"
#import "PAPhoto.h"

@implementation PANetworkService

+ (void)getDataWithRequest: (PANetworkRequest *)request completion: (void(^)(NSData * _Nullable data)) completion
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:request.requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data);
    }];
    [task resume];
}

+ (void)getPhotoList:(void (^)(NSArray<PAPhoto *> * _Nullable))completion
{
    [self getDataWithRequest:[PAPhotoListReqeust request] completion:^(NSData * _Nullable data) {

        if (data == nil) {
            completion(nil);
            return;
        }

        NSError *error;
        id jsonData =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&error];

        if (![jsonData isKindOfClass:[NSArray class]]) {
            completion(nil);
            return;
        }

        NSArray *photoListJSON = jsonData;
        NSMutableArray *photoList = [NSMutableArray array];
        for (NSDictionary *photoJSON in photoListJSON) {
            [photoList addObject:[PAPhoto photoWithJSON:photoJSON]];
        }
        completion(photoList);
    }];
}

+ (void)getPhotoWithURL:(NSURL *)photoURL completion:(void (^)(UIImage * _Nullable))completion
{
    [self getDataWithRequest:[PAImageRequest requestWithURL:photoURL] completion:^(NSData * _Nullable data) {

        if (data == nil) {
            completion(nil);
            return;
        }

        completion([UIImage imageWithData:data]);
    }];
}

@end
