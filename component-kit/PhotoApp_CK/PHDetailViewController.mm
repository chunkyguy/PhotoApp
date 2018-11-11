//
//  PHDetailViewController.m
//  PhotoApp_CK
//
//  Created by Sidharth Juyal on 11/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PHDetailViewController.h"
#import <ComponentKit/ComponentKit.h>
#import "PAPhoto.h"
#import "PAImageDownloader.h"
#import "PHDetailComponent.h"

@interface PHDetailViewController () <UICollectionViewDelegateFlowLayout> {
    PAPhoto *_photo;
    CKCollectionViewDataSource *_dataSource;
    UICollectionView *_collectionView;
    PAImageDownloader *_imageDownloader;
}

@end

@implementation PHDetailViewController

+ (instancetype)viewControlerWithPhoto:(PAPhoto *)photo imageDownloader:(nonnull PAImageDownloader *)imageDownloader
{
    return [[PHDetailViewController alloc] initWithPhoto:photo imageDownloader:imageDownloader];
}

- (instancetype)initWithPhoto: (PAPhoto *)photo
              imageDownloader:(nonnull PAImageDownloader *)imageDownloader
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _photo = photo;
        _imageDownloader = imageDownloader;
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

    _collectionView.delegate = self;
    self.view.backgroundColor = [UIColor grayColor];

    // set up data source
    _dataSource = [[CKCollectionViewDataSource alloc]
                   initWithCollectionView:_collectionView
                   supplementaryViewDataSource:nil
                   configuration:[[CKDataSourceConfiguration alloc]
                                  initWithComponentProvider:[self class]
                                  context:_imageDownloader
                                  sizeRange:[[CKComponentFlexibleSizeRangeProvider
                                              providerWithFlexibility:CKComponentSizeRangeFlexibleHeight]
                                             sizeRangeForBoundingSize:self.view.bounds.size]]];

    // render initial data
    CKDataSourceChangesetBuilder *builder = [CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset];
    [builder withInsertedSections:[NSIndexSet indexSetWithIndex:0]];
    [builder withInsertedItems:@{[NSIndexPath indexPathForRow:0 inSection:0]: _photo}];
    [_dataSource applyChangeset:[builder build] mode:CKUpdateModeAsynchronous userInfo:nil];
}
#pragma mark CKComponentProvider
+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context;
{
    return [PHDetailComponent newWithPhoto:(PAPhoto *)model imageDownloader:(PAImageDownloader *)context];
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
