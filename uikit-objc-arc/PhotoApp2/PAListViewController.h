//
//  WLListViewController_2.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PAListViewControllerDelegate;

@interface PAListViewController : UIViewController

- (instancetype)initWithDelegate:(id<PAListViewControllerDelegate>) delegate;

@end

NS_ASSUME_NONNULL_END
