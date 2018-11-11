//
//  PAListViewModel.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PAListItemViewModel;
@class PAPhoto;

@interface PAListViewModel : NSObject
@property (readonly) NSArray<PAPhoto *> *list;

- (void)loadPhotoList:(void (^)(BOOL))completion;
- (NSInteger)totalItems;

@end

NS_ASSUME_NONNULL_END
