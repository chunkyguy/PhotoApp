//
//  UIImage+PAColor.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "UIImage+PAColor.h"

@implementation UIImage (PAColor)
+ (instancetype)imageWithColor:(UIColor *)color;
{
    return [UIImage imageWithColor:color andSize:CGSizeMake(1, 1)];
}

+ (instancetype)imageWithColor:(UIColor *)color andSize:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    CGContextRef contex = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contex, [color CGColor]);
    CGContextFillRect(contex, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
