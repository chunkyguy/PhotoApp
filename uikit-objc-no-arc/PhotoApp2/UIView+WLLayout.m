//
//  UIView+WLLayout.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "UIView+WLLayoutt.h"

@implementation UIView (WLLayout)
- (void) wl_addSubview: (NSArray *)subviews;
{
    for (UIView *subview in subviews) {
        [self addSubview:(UIView *)subview];
        [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
}

- (void) wl_addConstraint: (NSArray *) asciiConstraints views: (NSDictionary<NSString *, id> *)views;
{
    for (NSString *format in asciiConstraints) {
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:format options: 0 metrics:NULL views:views]];
    }
}
@end
