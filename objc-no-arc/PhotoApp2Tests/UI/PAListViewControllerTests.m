//
//  WLListViewControllerTests.m
//  PhotoApp2Tests
//
//  Created by Sidharth Juyal on 25/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "../../PhotoApp2/UI/View Models/PAListViewModelType.h"
#import "../../PhotoApp2/UI/View Controller/PAListViewController.h"

#pragma mark - PAStubListViewModel -
@interface PAStubListViewModel : NSObject <PAListViewControllerDelegate>
@end

@implementation PAStubListViewModel
- (void) loadPhotoList: (void(^)(BOOL)) completion;
{
    completion(YES);
}
@end

#pragma mark - PAStubListViewModel -
@interface PAListViewControllerTests : FBSnapshotTestCase

@end

@implementation PAListViewControllerTests

-(void)setUp
{
    [super setUp];
    self.recordMode = NO;
}

- (void)testIfDefaultLayoutLooksGood
{
    PAListViewController *viewController = [[PAListViewController alloc] initWithViewModel:[PAStubListViewModel new]];
    FBSnapshotVerifyView([viewController view], nil);
}

@end
