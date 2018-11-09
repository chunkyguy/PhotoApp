//
//  PAImageCollectionViewCell.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAImageCollectionViewCell.h"
#import "UIView+WLLayoutt.h"
#import "PAListItemViewModel.h"
#import "PAImageLoader.h"

@interface PAImageCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;

- (void)setUp;
@end

@implementation PAImageCollectionViewCell
+ (NSString *)reuseIdentifier;
{
    return @"kPAImageCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.imageView = [[UIImageView alloc] init];
    [self wl_addSubview:@[self.imageView]];
    [self wl_addConstraint:@[@"V:|[_imageView]|", @"H:|[_imageView]|"]
                     views:NSDictionaryOfVariableBindings(_imageView)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)bindViewModel: (PAListItemViewModel *)viewModel;
{
    self.imageView.image = viewModel.image;

    PAImageCollectionViewCell * __weak weakSelf = self;
    [viewModel loadImageWithCompletion:^(BOOL success) {
        if (success) {
            weakSelf.imageView.image = viewModel.image;
        }
    }];
}
@end
