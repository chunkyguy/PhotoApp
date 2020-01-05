//
//  PAImageCollectionViewCell.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAImageCollectionViewCell.h"
#import "UIView+WLLayoutt.h"
#import "PAPhoto.h"
#import "PAImageLoader.h"

@interface PAImageCollectionViewCell()
{
  UIImageView *_imageView;
  PAPhoto *_photo;
  ImageResolution _resolution;
}
- (void)setUp;
@end

@implementation PAImageCollectionViewCell
+ (NSString *)reuseIdentifier;
{
  return @"kPAImageCollectionViewCell";
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

- (void)dealloc
{
  [_imageView release];
  [super dealloc];
}

- (void)setUp
{
  _imageView = [[UIImageView alloc] init];
  [self wl_addSubview:@[_imageView]];
  [self wl_addConstraint:@[@"V:|[_imageView]|", @"H:|[_imageView]|"]
                   views:NSDictionaryOfVariableBindings(_imageView)];
  [_imageView setContentMode:UIViewContentModeScaleAspectFit];
  _imageView.image = [PAImageLoader placehoderlmage];
}

- (void)prepareForReuse
{
  [super prepareForReuse];
  _imageView.image = [PAImageLoader placehoderlmage];
}

-(void)setPhoto:(PAPhoto *)photo resolution:(ImageResolution)resolution;
{
  _photo = photo;
  _resolution = resolution;
  [self reloadImage];
}

- (void)reloadImage
{
  _imageView.image = [_photo imageWithResolution:_resolution];
}
@end
