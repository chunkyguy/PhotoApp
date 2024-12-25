//
//  PAListItemViewModel.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 31/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAListItemViewModel.h"
#import <UIKit/UIKit.h>
#import "PAImageLoader.h"

@interface PAListItemViewModel ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) PAPhoto *photo;
@end

@implementation PAListItemViewModel
+ (instancetype)itemViewModelWithPhoto:(PAPhoto *)photo
{
    return [[PAListItemViewModel alloc] initWithPhoto:photo];
}

- (instancetype)initWithPhoto:(PAPhoto *)photo
{
    self = [super init];
    if (self) {
        _photo = photo;
        _image = [PAImageLoader placeholderImage];
    }
    return self;
}

- (void)loadImageWithCompletion:(void (^)(BOOL))completion
{
    __weak PAListItemViewModel *weakSelf = self;
    [PAImageLoader loadPhoto:self.photo resolution:ImageResolutionThumbnail completion:^(UIImage * _Nonnull image) {
        weakSelf.image = image;
        completion(image != nil);
    }];
}

- (NSString *)title;
{
    return self.photo.title;
}

@end
