//
//  PAPhotoListReqeust.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAPhotoListReqeust.h"

@implementation PAPhotoListReqeust

+ (instancetype)request
{
    return [PAPhotoListReqeust new];
}

- (NSURL *)requestURL
{
    return [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/photos"];
}

@end
