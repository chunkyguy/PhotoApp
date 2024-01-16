//
//  PAImageCollectionViewCell.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PAListItemViewModel;

@interface PAImageCollectionViewCell : UICollectionViewCell
+ (NSString *)reuseIdentifier;
- (void)bindViewModel: (PAListItemViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
