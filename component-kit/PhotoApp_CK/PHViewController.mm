//
//  ViewController.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHViewController.h"

#import <ComponentKit/ComponentKit.h>

#import "PAListViewModel.h"
#import "PAPhoto.h"
#import "PAImageDownloader.h"
#import "PHRootComponentProvider.h"
#import "PHDetailViewController.h"

@interface PHViewController () <UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    CKCollectionViewDataSource *_dataSource;
    PAListViewModel *_viewModel;
    PAImageDownloader *_imageDownloader;
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
        _viewModel = [[PAListViewModel alloc] init];
        _imageDownloader = [[PAImageDownloader alloc] init];
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

    _collectionView.delegate = self;
    self.view.backgroundColor = [UIColor grayColor];

    // set up data source
    _dataSource = [[CKCollectionViewDataSource alloc]
                   initWithCollectionView:_collectionView
                   supplementaryViewDataSource:nil
                   configuration:[[CKDataSourceConfiguration alloc]
                                  initWithComponentProvider:[PHRootComponentProvider class]
                                  context:self
                                  sizeRange:[[CKComponentFlexibleSizeRangeProvider
                                              providerWithFlexibility:CKComponentSizeRangeFlexibleHeight]
                                             sizeRangeForBoundingSize:self.view.bounds.size]]];

    // render initial data
    CKDataSourceChangeset *initialData = [[[CKDataSourceChangesetBuilder dataSourceChangeset]
                                           withInsertedSections:[NSIndexSet indexSetWithIndex:0]]build];
    [_dataSource applyChangeset:initialData mode:CKUpdateModeAsynchronous userInfo:nil];

    [self fetchImages];
}

- (void)showLoadingComponent
{
    NSDictionary<NSIndexPath *, NSObject *> *loadingItem = @{[NSIndexPath indexPathForRow:0 inSection:0]: [NSNull null]};
    CKDataSourceChangeset *loadingData = [[[CKDataSourceChangesetBuilder dataSourceChangeset] withInsertedItems:loadingItem] build];
    [_dataSource applyChangeset:loadingData mode:CKUpdateModeAsynchronous userInfo:nil];
}

- (void)fetchImages
{
    [self showLoadingComponent];
    __weak PHViewController *weakSelf = self;
    [_viewModel loadPhotoList:^(BOOL isGood) {
        if (isGood) {
            [weakSelf updateImages];
        }
    }];
}

- (void)updateImages
{
    NSArray<PAPhoto *> *images = _viewModel.list;
    NSMutableDictionary<NSIndexPath *, PAPhoto *> *photoList = [NSMutableDictionary dictionaryWithCapacity:images.count];
    for (NSInteger idx = 0; idx < [images count]; ++idx) {
        [photoList
         setObject:images[idx]
         forKey:[NSIndexPath indexPathForRow:idx inSection:0]];
    }

    CKDataSourceChangeset *loadingData = [[[CKDataSourceChangesetBuilder dataSourceChangeset] withInsertedItems:photoList] build];
    [_dataSource applyChangeset:loadingData mode:CKUpdateModeAsynchronous userInfo:nil];
}

- (void)onTap:(PAPhoto *)photo
{
    [self
     showViewController:[PHDetailViewController viewControlerWithPhoto:photo imageDownloader:_imageDownloader]
     sender:self];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dataSource sizeForItemAtIndexPath:indexPath];
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
