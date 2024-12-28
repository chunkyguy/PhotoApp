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
#import "PAListItemViewModel.h"

@interface PAListViewModel ()
@property (nonatomic, strong) NSArray *list;
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

- (void) listViewController:(PAListViewController *)viewController loadPhotoList:(void (^)(BOOL))completion
{
    __weak PAListViewModel *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PANetworkService getPhotoList:^(NSArray<PAPhoto *> * _Nullable photoList) {
            weakSelf.list = photoList;
            dispatch_async(dispatch_get_main_queue(), ^{ completion(photoList != nil); });
        }];
    });
}

- (nonnull PAListItemViewModel *)listViewController:(nonnull PAListViewController *)viewController itemAtIndex:(NSInteger)index {
    NSAssert(index < [self.list count], @"out of bounds");
    return [PAListItemViewModel itemViewModelWithPhoto:[self.list objectAtIndex:index]];
}


- (NSInteger)totalItemsListViewController:(nonnull PAListViewController *)viewController {
//    return 0;
    return [self.list count];
}


@end
