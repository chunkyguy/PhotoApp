//
//  WLListViewModel2.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PAListViewController;
@class PAListItemViewModel;

@protocol PAListViewControllerDelegate
- (NSInteger)totalItemsListViewController: (PAListViewController *) viewController;
- (PAListItemViewModel *)listViewController:(PAListViewController *)viewController itemAtIndex: (NSInteger)index;
- (void) listViewController: (PAListViewController *)viewController loadPhotoList: (void(^)(BOOL)) completion;
@end

NS_ASSUME_NONNULL_END
