//
//  PANetworkService.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 29/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PAPhoto;

@protocol PANetworkServiceDelegate;

@interface PANetworkService : NSObject

- (void)getPhotoList;
- (void)getPhotoWithURL:(NSURL *)photoURL;

@property (nonatomic, assign) id<PANetworkServiceDelegate> delegate;
@end

@protocol PANetworkServiceDelegate <NSObject>

@optional
- (void)networkService:(PANetworkService *)networkService didFetchPhotoList:(NSArray *)photoList;
- (void)networkService:(PANetworkService *)networkService didFetchPhoto:(UIImage *)image forURL:(NSURL *)photoURL;

@end
