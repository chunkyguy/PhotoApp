//
//  WLListViewController_2.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAListViewController.h"
#import "UIImage+PAColor.h"
#import "PAImageCollectionViewCell.h"
#import "PADetailViewController.h"
#import "PAPhotoController.h"

static const CGFloat kInterspacing = 16.0;

@interface PAListViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PAPhotoControllerDelegate>
{
  PAPhotoController *_controller;
}
@property (assign, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PAListViewController

+ (instancetype)listViewControllertWithController:(PAPhotoController *)controller;
{
  return [[[self alloc] initWithController:controller] autorelease];
}

- (instancetype)initWithController:(PAPhotoController *)controller
{
  if (self = [super initWithNibName:@"PAListViewController" bundle:nil]) {
    _controller = [controller retain];
    [_controller setDelegate: self];
  }
  return self;
}

- (void)dealloc
{
  [_controller release];
  [super dealloc];
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.view setBackgroundColor:[UIColor darkGrayColor]];

  [_activityIndicator setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
  [_activityIndicator setHidesWhenStopped:YES];

  [_collectionView setBackgroundColor:[UIColor darkGrayColor]];
  [_collectionView registerClass:[PAImageCollectionViewCell class]
      forCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]];
  [_collectionView setDataSource:self];
  [_collectionView setDelegate:self];

  [self loadPhotoList];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [_controller setDelegate: self];
}

#pragma mark - private
- (void)loadPhotoList
{
  [_activityIndicator startAnimating];
  [_controller loadPhotoList];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_controller totalItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]
                                                                         forIndexPath:indexPath];
  if ([cell isKindOfClass:[PAImageCollectionViewCell class]]) {

    PAPhoto *photo = [_controller itemAtIndex:indexPath.item];
    ImageResolution resolution = ImageResolutionThumbnail;

    [_controller loadPhoto:photo withResolution:resolution];
    [(PAImageCollectionViewCell *)cell setPhoto:photo resolution:resolution];
  }

  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  CGSize size = collectionView.bounds.size;
  return CGSizeMake(size.width/2.0, 200);
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
  return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
{
  return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self showViewController:[PADetailViewController viewControllerWithPhoto:[_controller itemAtIndex:indexPath.item] controller: _controller]
                    sender:self];
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
  for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
    if ([cell isKindOfClass:[PAImageCollectionViewCell class]]) {
      [(PAImageCollectionViewCell *)cell reloadImage];
    }
  }
}

@end
