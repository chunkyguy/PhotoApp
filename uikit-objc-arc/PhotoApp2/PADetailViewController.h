//
//  PADetailViewController.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 28/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PAListItemViewModel;

@interface PADetailViewController : UIViewController
+ (instancetype)viewControllerWithViewModel:(PAListItemViewModel *)viewModel;
-(instancetype)initWithViewModel:(PAListItemViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
