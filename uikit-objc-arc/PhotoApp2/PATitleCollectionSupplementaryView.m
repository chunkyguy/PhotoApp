//
//  PATitleCollectionSupplementaryView.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PATitleCollectionSupplementaryView.h"
#import "UIView+WLLayoutt.h"
#import "PAListItemViewModel.h"

@interface PATitleCollectionSupplementaryView ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation PATitleCollectionSupplementaryView
+ (NSString *)reuseIdentifier;
{
    return @"kPATitleCollectionSupplementaryView";
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
    self.label = [[UILabel alloc] init];
    [self wl_addSubview:@[self.label]];
    [self wl_addConstraint:@[@"V:|[_label]|", @"H:|[_label]|"]
                     views:NSDictionaryOfVariableBindings(_label)];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
}

- (void)bindViewModel: (PAListItemViewModel *)viewModel;
{
    self.label.text = viewModel.title;
}

@end
