//
//  PAListItemViewModel.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 31/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PAPhoto;
@class PADetailViewModel;

@interface PAListItemViewModel : NSObject

+ (instancetype)itemViewModelWithPhoto: (PAPhoto *)photo;
- (instancetype)initWithPhoto:(PAPhoto *)photo;

- (void)loadImageWithCompletion: (void(^)(BOOL success))completion;

@property (readonly) UIImage *image;
@property (readonly) NSString *title;
@end

NS_ASSUME_NONNULL_END
