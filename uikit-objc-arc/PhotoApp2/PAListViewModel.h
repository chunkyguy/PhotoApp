//
//  PAListViewModel.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAListViewControllerDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface PAListViewModel : NSObject <PAListViewControllerDelegate>
@property (readonly) NSArray *list;

@end

NS_ASSUME_NONNULL_END
