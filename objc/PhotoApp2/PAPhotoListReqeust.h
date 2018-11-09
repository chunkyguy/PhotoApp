//
//  PAPhotoListReqeust.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 30/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PANetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PAPhotoListReqeust : PANetworkRequest

+ (instancetype)request;

@property (readonly, nonatomic) NSURL *requestURL;

@end

NS_ASSUME_NONNULL_END
