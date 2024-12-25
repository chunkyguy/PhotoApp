//
//  AppEngine.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PAAppEngine : NSObject
+ (instancetype)engine;
- (instancetype)initWithWindow: (UIWindow *)aWindow;
@end

NS_ASSUME_NONNULL_END
