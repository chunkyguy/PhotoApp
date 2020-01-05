//
//  UIView+WLLayout.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLLayout)
- (void) wl_addSubview: (NSArray *)subviews;
- (void) wl_addConstraint: (NSArray *) asciiConstraints views: (NSDictionary<NSString *, id> *) viewsDict;
@end
