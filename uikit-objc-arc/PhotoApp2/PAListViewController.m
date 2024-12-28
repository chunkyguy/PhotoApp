//
//  WLListViewController_2.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PAListViewController.h"
#import "PAListViewControllerDelegate.h"
#import "UIImage+PAColor.h"
#import "PAImageCollectionViewCell.h"
#import "PADetailViewController.h"

static const CGFloat kInterspacing = 16.0;

@interface PAListViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) id<PAListViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PAListViewController

- (instancetype)initWithDelegate:(id<PAListViewControllerDelegate>) delegate;
{
    self = [super initWithNibName:@"PAListViewController" bundle:nil];
    if (!self) {
        return nil;
    }
    self.delegate = delegate;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blackColor;

    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.activityIndicator.hidesWhenStopped = YES;

    self.collectionView.backgroundColor = UIColor.blackColor;
    [self.collectionView
     registerClass:[PAImageCollectionViewCell class]
     forCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self loadPhotoList];
}

#pragma mark - private
- (void)loadPhotoList
{
    [_activityIndicator startAnimating];

    PAListViewController * __weak weakSelf = self;
    [self.delegate listViewController:self loadPhotoList:^(BOOL success) {
        NSAssert(weakSelf != nil, @"Memory leak!");
        [weakSelf.activityIndicator stopAnimating];

        if (success) {
            [weakSelf.collectionView reloadData];
        }
    }];
}

- (PAListItemViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.delegate listViewController:self itemAtIndex:indexPath.item];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.delegate totalItemsListViewController:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PAImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       [PAImageCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell bindViewModel:[self viewModelAtIndexPath:indexPath]];
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
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
{
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showViewController:[PADetailViewController viewControllerWithViewModel:[self viewModelAtIndexPath:indexPath]]
                      sender:self];
}
@end
