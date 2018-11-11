//
//  PANetworkRequest.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PANetworkRequest.h"

#pragma mark PANetworkRequest
@implementation PANetworkRequest

- (NSURL *)requestURL
{
    NSAssert(false, @"Needs to be subclassed");
    return [NSURL fileURLWithPath:@"/dev/null"];
}

@end
