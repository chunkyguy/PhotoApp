//
//  PAListViewModel.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAListViewModel.h"
#import "PAPhoto.h"
#import "PANetworkService.h"

@interface PAListViewModel ()
@property (nonatomic, strong) NSArray<PAPhoto *> *list;
@end

@implementation PAListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _list = [NSArray array];
    }
    return self;
}

- (void)loadPhotoList:(void (^)(BOOL))completion
{
    __weak PAListViewModel *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PANetworkService getPhotoList:^(NSArray<PAPhoto *> * _Nullable photoList) {
            weakSelf.list = photoList;
            dispatch_async(dispatch_get_main_queue(), ^{ completion(photoList != nil); });
        }];
    });
}

- (NSInteger)totalItems
{
    return [self.list count];
}


@end
