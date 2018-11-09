//
//  PADetailViewController.m
//  PhotoApp2
//
//  Created by Sidharth Juyal on 28/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "PADetailViewController.h"
#import "PAListItemViewModel.h"
#import "PAImageCollectionViewCell.h"
#import "PATitleCollectionSupplementaryView.h"

static const CGFloat kInterspacing = 16.0;

@interface PADetailViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) PAListItemViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation PADetailViewController

+ (instancetype)viewControllerWithViewModel:(PAListItemViewModel *)viewModel;
{
    return [[PADetailViewController alloc] initWithViewModel:viewModel];
}

-(instancetype)initWithViewModel:(PAListItemViewModel *)viewModel;
{
    self = [super initWithNibName:@"PADetailViewController" bundle:nil];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[PAImageCollectionViewCell class]
            forCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]];

    [self.collectionView registerClass:[PATitleCollectionSupplementaryView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[PATitleCollectionSupplementaryView reuseIdentifier]];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
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
    PATitleCollectionSupplementaryView *headerView = [collectionView
                                                      dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                      withReuseIdentifier:[PATitleCollectionSupplementaryView reuseIdentifier]
                                                      forIndexPath:indexPath];
    [headerView bindViewModel:self.viewModel];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PAImageCollectionViewCell *cell = [collectionView
                                       dequeueReusableCellWithReuseIdentifier:[PAImageCollectionViewCell reuseIdentifier]
                                       forIndexPath:indexPath];
    [cell bindViewModel:self.viewModel];
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
@end
