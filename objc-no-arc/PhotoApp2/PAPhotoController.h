//
//  PAPhotoController.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAPhoto.h"

@protocol PAPhotoControllerDelegate;

@interface PAPhotoController : NSObject
+ (instancetype)controller;

- (void)loadPhotoList;
- (void)loadPhoto:(PAPhoto *)photo withResolution:(ImageResolution)resolution;

- (PAPhoto *)itemAtIndex:(NSInteger)index;
- (NSInteger)totalItems;

@property (nonatomic, assign) id<PAPhotoControllerDelegate> delegate;

@end

@protocol PAPhotoControllerDelegate <NSObject>

- (void)listController:(PAPhotoController *)controller didFetchListWithSuccess:(BOOL)success;
- (void)listController:(PAPhotoController *)controller didFetchPhoto:(PAPhoto *)photo;

@end
