//
//  PADetailViewController.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 28/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PADetailViewController.h"
#import "PAImageCollectionViewCell.h"
#import "PATitleCollectionSupplementaryView.h"
#import "PAPhoto.h"
#import "PAPhotoController.h"

static const CGFloat kInterspacing = 16.0;

@interface PADetailViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PAPhotoControllerDelegate>
{
  PAPhoto *_photo;
  PAPhotoController *_controller;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PADetailViewController

+ (instancetype)viewControllerWithPhoto:(PAPhoto *)photo controller:(PAPhotoController *)controller;
{
  return [[[PADetailViewController alloc] initWithPhoto:photo controller:controller] autorelease];
}

- (instancetype)initWithPhoto:(PAPhoto *)photo controller:(PAPhotoController *)controller;
{
  if (self = [super initWithNibName:@"PADetailViewController" bundle:nil]) {
    _photo = [photo retain];
    _controller = controller;
  }
  return self;
}

- (void)dealloc
{
  [_photo release];
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [_activityIndicator setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
  [_activityIndicator setHidesWhenStopped:YES];

  [_collectionView registerClass:[PAImageCollectionViewCell class]
      forCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]];

  [_collectionView registerClass:[PATitleCollectionSupplementaryView class]
      forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
             withReuseIdentifier:[PATitleCollectionSupplementaryView reuseIdentifier]];

  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];
  [_collectionView setBackgroundColor:[UIColor darkGrayColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [_controller setDelegate: self];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
  return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
  UICollectionReusableView *headerView = [collectionView
                                          dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                          withReuseIdentifier:[PATitleCollectionSupplementaryView reuseIdentifier]
                                          forIndexPath:indexPath];
  if ([headerView isKindOfClass:[PATitleCollectionSupplementaryView class]]) {
    [(PATitleCollectionSupplementaryView *)headerView setPhoto:_photo];
  }
  return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  UICollectionViewCell *cell = [collectionView
                                dequeueReusableCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]
                                forIndexPath:indexPath];

  if ([cell isKindOfClass:[PAImageCollectionViewCell class]]) {
    ImageResolution resolution = ImageResolutionFull;
    [_controller loadPhoto:_photo withResolution:resolution];
    [(PAImageCollectionViewCell *)cell setPhoto:_photo resolution:resolution];
  }

  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  CGSize size = collectionView.bounds.size;
  return CGSizeMake(size.width - kInterspacing * 2.0, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
  return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
  return kInterspacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
  return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
  CGSize size = collectionView.bounds.size;
  return CGSizeMake(size.width, 200.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
{
  return CGSizeZero;
}

#pragma mark - PAPhotoControllerDelegate
- (void)listController:(PAPhotoController *)controller didFetchListWithSuccess:(BOOL)success
{
  [_activityIndicator stopAnimating];
  if (success) {
    [self.collectionView reloadData];
  }
}

- (void)listController:(PAPhotoController *)controller didFetchPhoto:(PAPhoto *)photo
{
  [_activityIndicator stopAnimating];
  for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
    if ([cell isKindOfClass:[PAImageCollectionViewCell class]]) {
      [(PAImageCollectionViewCell *)cell reloadImage];
    }
  }
}

@end

