//
//  PHLoadingComponent.h
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 10/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ComponentKit/ComponentKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHLoadingComponent : CKCompositeComponent
+ (instancetype)newWithTintColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
