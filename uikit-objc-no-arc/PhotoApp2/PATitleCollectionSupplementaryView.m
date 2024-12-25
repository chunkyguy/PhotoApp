//
//  PATitleCollectionSupplementaryView.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PATitleCollectionSupplementaryView.h"
#import "UIView+WLLayoutt.h"
#import "PAPhoto.h"

@interface PATitleCollectionSupplementaryView ()
{
  UILabel *_label;
}
@end

@implementation PATitleCollectionSupplementaryView
+ (NSString *)reuseIdentifier;
{
  return @"kPATitleCollectionSupplementaryView";
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self setUp];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self setUp];
  }
  return self;
}

- (void)setUp
{
  _label = [[UILabel alloc] init];
  [self wl_addSubview:@[_label]];
  [self wl_addConstraint:@[@"V:|[_label]|", @"H:|[_label]|"]
                   views:NSDictionaryOfVariableBindings(_label)];
  [_label setTextColor:[UIColor whiteColor]];
  [_label setTextAlignment:NSTextAlignmentCenter];
  [_label setNumberOfLines:0];
}

- (void)setPhoto:(PAPhoto *)photo;
{
  [_label setText:[photo title]];
}

@end
