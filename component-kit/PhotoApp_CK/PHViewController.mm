//
//  ViewController.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHViewController.h"
#include <vector>
#import <ComponentKit/ComponentKit.h>
#import "PHLoadingComponent.h"

@interface PHViewController () {
    UICollectionView *_collectionView;
    CKCollectionViewDataSource *_dataSource;
}

@end

@implementation PHViewController

+ (instancetype)viewController
{
    return [[PHViewController alloc] initWithNibName:nil bundle:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // add root views
    [self.view addSubview:_collectionView];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray<NSString *> *formats = @[@"H:|[C]|", @"V:|[C]|"];
    for (NSString *format in formats) {
        [self.view
         addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"C": _collectionView}]];
    }

    self.view.backgroundColor = [UIColor grayColor];

    // set up data source
    _dataSource = [[CKCollectionViewDataSource alloc]
                   initWithCollectionView:_collectionView
                   supplementaryViewDataSource:nil
                   configuration:[[CKDataSourceConfiguration alloc]
                                  initWithComponentProvider:[self class]
                                  context:nil
                                  sizeRange:[[CKComponentFlexibleSizeRangeProvider
                                              providerWithFlexibility:CKComponentSizeRangeFlexibleHeight]
                                             sizeRangeForBoundingSize:self.view.bounds.size]]];

    // render initial data
    CKDataSourceChangeset *initialData = [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
                                           withInsertedSections:[NSIndexSet indexSetWithIndex:0]]build];
    [_dataSource applyChangeset:initialData mode:CKUpdateModeAsynchronous userInfo:nil];

    [self showLoadingComponent];
}

- (void)showLoadingComponent
{
    NSDictionary<NSIndexPath *, NSObject *> *loadingItem = @{[NSIndexPath indexPathForRow:0 inSection:0]: [NSNull null]};
    CKDataSourceChangeset *loadingData = [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset] withInsertedItems:loadingItem] build];
    [_dataSource applyChangeset:loadingData mode:CKUpdateModeAsynchronous userInfo:nil];
}

#pragma mark CKComponentProvider
+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context;
{
    if ([model isKindOfClass:[NSNull class]]) {
        return [PHLoadingComponent newWithTintColor:[UIColor redColor]];
    }
    return nil;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataSource announceWillDisplayCell:cell];
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataSource announceDidEndDisplayingCell:cell];
}

@end
