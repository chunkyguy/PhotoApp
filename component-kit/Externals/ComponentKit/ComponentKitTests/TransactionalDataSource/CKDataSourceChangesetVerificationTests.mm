/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <Foundation/Foundation.h>

#import <XCTest/XCTest.h>

#import <ComponentKit/CKComponentLayout.h>
#import <ComponentKit/CKDataSourceChangeset.h>
#import <ComponentKit/CKDataSourceChangesetModification.h>
#import <ComponentKit/CKDataSourceItemInternal.h>
#import <ComponentKit/CKDataSourceStateInternal.h>
#import <ComponentKitTestHelpers/CKChangesetHelpers.h>

#import "CKDataSourceChangesetVerification.h"
#import "CKDataSourceStateTestHelpers.h"

@interface CKDataSourceChangesetVerificationTests : XCTestCase
@end

@implementation CKDataSourceChangesetVerificationTests

#pragma mark - Valid changesets

- (void)assertEqualChangesetInfoWith:(CKInvalidChangesetInfo)lhs target:(CKInvalidChangesetInfo)rhs
{
  XCTAssertEqual(lhs.operationType, rhs.operationType);
  XCTAssertEqual(lhs.section, rhs.section);
  XCTAssertEqual(lhs.item, rhs.item);
}

- (void)test_emptyChangesetEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  CKDataSourceChangeset *changeset =
  [[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
   build];
  
  [self assertEqualChangesetInfoWith:kChangeSetValid target:CKIsValidChangesetForState(changeset, state, nil)];
}

- (void)test_emptyChangesetNonEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"A"),
                                                                             itemWithModel(@"B"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
   build];
  
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_nonEmptyChangesetEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  CKDataSourceChangeset *changeset =
  [[[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
     withInsertedSections:[NSIndexSet indexSetWithIndex:0]]
    withInsertedItems:@{
                       [NSIndexPath indexPathForItem:0 inSection:0]: @"A",
                       [NSIndexPath indexPathForItem:1 inSection:0]: @"B",
                       }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionIntoEmptySection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:0 inSection:0]: @"A",
                        [NSIndexPath indexPathForItem:1 inSection:0]: @"B",
                        }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionIntoBeginningOfNonEmptySection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:0 inSection:0]: @"A",
                        [NSIndexPath indexPathForItem:1 inSection:0]: @"B",
                        }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionIntoMiddleOfNonEmptySection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:1 inSection:0]: @"A",
                        [NSIndexPath indexPathForItem:2 inSection:0]: @"B",
                        }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionAtEndOfNonEmptySection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:2 inSection:0]: @"A",
                        [NSIndexPath indexPathForItem:3 inSection:0]: @"B",
                        }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validRemovalAtBeginningOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             itemWithModel(@"E"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:0 inSection:0],
                                           ]]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validRemovalAtMiddleOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             itemWithModel(@"E"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:1 inSection:0],
                                           ]]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validRemovalAtEndOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             itemWithModel(@"E"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:2 inSection:0],
                                           ]]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validRemovalOfAllItems
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             itemWithModel(@"E"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:2 inSection:0],
                                           [NSIndexPath indexPathForItem:1 inSection:0],
                                           [NSIndexPath indexPathForItem:0 inSection:0],
                                           ]]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionOfSectionInEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedSections:[NSIndexSet indexSetWithIndex:0]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionOfSectionAtBeginningOfNonEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedSections:[NSIndexSet indexSetWithIndex:0]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionOfSectionInMiddleOfNonEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedSections:[NSIndexSet indexSetWithIndex:1]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionOfSectionAtEndOfNonEmptySections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedSections:[NSIndexSet indexSetWithIndex:2]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInsertionOfMultipleSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_removalOfSectionAtBeginningOfSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedSections:[NSIndexSet indexSetWithIndex:0]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_removalOfSectionAtMiddleOfSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedSections:[NSIndexSet indexSetWithIndex:1]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_removalOfSectionAtEndOfSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedSections:[NSIndexSet indexSetWithIndex:2]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_removeMultipleSectionsAtBeginningOfSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_removeMultipleSectionsAtEndOfSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validUpdate
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withUpdatedItems:@{
                       [NSIndexPath indexPathForItem:0 inSection:0]: @"A",
                       }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validMoveForwardInsideOneSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:0 inSection:0]: [NSIndexPath indexPathForItem:1 inSection:0],
                     }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validMoveBackwardInsideOneSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:1 inSection:0]: [NSIndexPath indexPathForItem:0 inSection:0],
                     }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validMoveForwardBetweenSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:0 inSection:0]: [NSIndexPath indexPathForItem:2 inSection:1],
                     }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validMoveBackwardBetweenSections
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"E"),
                                                                             itemWithModel(@"F"),
                                                                             ],
                                                                           @[
                                                                             itemWithModel(@"G"),
                                                                             itemWithModel(@"H"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:0 inSection:1]: [NSIndexPath indexPathForItem:2 inSection:0],
                     }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validMoveBackwardWithOriginalIndexRemoved
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"A"),
                                                                             itemWithModel(@"B"),
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                            ]];
  // Changeset for transition from [A, B, C, D] to [D, A]
  CKDataSourceChangeset *changeset =
  [[[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
     withMovedItems:@{
                      [NSIndexPath indexPathForItem:3 inSection:0] : [NSIndexPath indexPathForItem:0 inSection:0],
                      }]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:1 inSection:0],
                                           [NSIndexPath indexPathForItem:2 inSection:0],
                                           ]]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_WhenVerifyingMovesWithSectionRemoval_ValidatesFromIndexPathsAgainstOriginalState
{
  const auto state = CKDataSourceTestState(Nil, nil, 2, 20);
  const auto changeset = CK::makeChangeset({
    .removedSections = {
      0,
    },
    .movedItems = {
      {{1, 1}, {0, 9}},
      {{1, 4}, {0, 17}},
      {{1, 18}, {0, 13}},
      {{1, 19}, {0, 5}},
    },
  });

  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_WhenVerifyingMovesWithSectionInsertion_ValidatesFromIndexPathsAgainstOriginalState
{
  const auto state = CKDataSourceTestState(Nil, nil, 1, 20);
  const auto changeset = CK::makeChangeset({
    .movedItems = {
      {{0, 1}, {1, 9}},
      {{0, 4}, {1, 17}},
      {{0, 18}, {1, 13}},
      {{0, 19}, {1, 5}},
    },
    .insertedSections = {
      0
    },
  });

  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_WhenVerifyingMovesWithBothSectionInsertionsAndRemovals_ValidatesFromIndexPathsAgainstOriginalState
{
  const auto state = CKDataSourceTestState(Nil, nil, 2, 20);
  const auto changeset = CK::makeChangeset({
    .removedSections = {
      0,
    },
    .movedItems = {
      {{1, 1}, {1, 9}},
      {{1, 4}, {1, 17}},
      {{1, 18}, {1, 13}},
      {{1, 19}, {1, 5}},
    },
    .insertedSections = {
      0
    },
  });

  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_WhenApplyingPendingModificationsWithMoves_TreatsToIndexPathsAsSpecifiedAfterSectionRemovalsAndInsertions
{
  const auto state = CKDataSourceTestState(Nil, nil, 5, 1);
  const auto pendingChangeset = CK::makeChangeset({
    .removedSections = {
      0, 2
    },
    .movedItems = {
      {{3, 0}, {4, 0}},
    },
    .insertedSections = {
      0, 2, 3
    },
    .insertedItems = {
      {{0, 0}, @"New"},
      {{2, 0}, @"New"},
      {{3, 0}, @"New"},
    }
  });
  const auto pendingModification = [[CKDataSourceChangesetModification alloc] initWithChangeset:pendingChangeset
                                                                                  stateListener:nil
                                                                                       userInfo:nil];
  const auto changeset = CK::makeChangeset({
    .removedSections = {
      0, 3
    },
    .movedItems = {
      {{4, 0}, {4, 0}},
    },
    .insertedSections = {
      0, 3
    },
    .insertedItems = {
      {{0, 0}, @"New2"},
      {{3, 0}, @"New2"},
    }
  });

  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, @[pendingModification])
                              target:kChangeSetValid];
}

#pragma mark - Invalid changesets

- (void)test_invalidUpdateInNegativeSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withUpdatedItems:@{
                       [NSIndexPath indexPathForItem:1 inSection:-1]: @"A",
                       }]
   build];
  
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeUpdate, -1, 1 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidUpdateInNegativeItem
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withUpdatedItems:@{
                       [NSIndexPath indexPathForItem:-1 inSection:0]: @"A",
                       }]
   build];
  
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeUpdate, 0, -1 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidInsertionAtEndOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:3 inSection:0]: @"A",
                        }]
   build];
  
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeInsertRow, 0, 3 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidMultipleInsertionAtEndOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:2 inSection:0]: @"A",
                        [NSIndexPath indexPathForItem:4 inSection:0]: @"B",
                        [NSIndexPath indexPathForItem:5 inSection:0]: @"E",
                        }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeInsertRow, 0, 4 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidInsertionInNonExistentSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:0 inSection:1]: @"A",
                        }]
   build];
  
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeInsertRow, 1, 0 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidRemovalInValidSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:2 inSection:0],
                                           ]]]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeRemoveRow, 0, 2 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidRemovalInNonExistentSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:0 inSection:1],
                                           ]]]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeRemoveRow, 1, 0 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidInsertionOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedSections:[NSIndexSet indexSetWithIndex:2]]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeInsertSection, 2, -1 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidRemovalOfSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedSections:[NSIndexSet indexSetWithIndex:2]]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeRemoveSection, 2, -1 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidUpdateWithinExistingSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withUpdatedItems:@{
                       [NSIndexPath indexPathForItem:2 inSection:0]: @"A",
                       }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeUpdate, 0, 2 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_invalidUpdateWithinNonExistentSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withUpdatedItems:@{
                       [NSIndexPath indexPathForItem:0 inSection:1]: @"A",
                       }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeUpdate, 1, 0 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_moveWithInvalidOriginIndexPathInExistingSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:2 inSection:0]: [NSIndexPath indexPathForItem:0 inSection:0],
                     }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeMoveRow, 0, 2 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_moveWithInvalidDestinationIndexPathInExistingSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:0 inSection:0]: [NSIndexPath indexPathForItem:2 inSection:0],
                     }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeMoveRow, 0, 2 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_moveWithInvalidOriginSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:0 inSection:1]: [NSIndexPath indexPathForItem:0 inSection:0],
                     }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeMoveRow, 1, -1 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

- (void)test_moveWithInvalidDestinationSection
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[
                                                                           @[
                                                                             itemWithModel(@"C"),
                                                                             itemWithModel(@"D"),
                                                                             ],
                                                                           ]];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withMovedItems:@{
                     [NSIndexPath indexPathForItem:0 inSection:0]: [NSIndexPath indexPathForItem:0 inSection:1],
                     }]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeMoveRow, 1, -1 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:target];
}

#pragma mark - More complicated situations

- (void)test_validInitialSectionInsertionsWithItemInsertions
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  CKDataSourceChangeset *changeset =
  [[[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
     withInsertedSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:0 inSection:0]: @"A1",
                        [NSIndexPath indexPathForItem:1 inSection:0]: @"B1",
                        [NSIndexPath indexPathForItem:0 inSection:1]: @"A2",
                        [NSIndexPath indexPathForItem:1 inSection:1]: @"B2",
                        }]
   build];
  
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, nil) target:kChangeSetValid];
}

- (void)test_validInitialSectionInsertionsInPendingAsynchronousModificationWithItemInsertions
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  NSArray<id<CKDataSourceStateModifying>> *pendingAsynchronousModifications =
  @[
    // Insert section 0 and section 1
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]
      build]
     stateListener:nil
     userInfo:nil],
    ];
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withInsertedItems:@{
                        [NSIndexPath indexPathForItem:0 inSection:0]: @"A1",
                        [NSIndexPath indexPathForItem:1 inSection:0]: @"B1",
                        [NSIndexPath indexPathForItem:0 inSection:1]: @"A2",
                        [NSIndexPath indexPathForItem:1 inSection:1]: @"B2",
                        }]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, pendingAsynchronousModifications) target:kChangeSetValid];
}

- (void)test_validChangesetAppliedToValidPendingAsynchronousModifications
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  NSArray<id<CKDataSourceStateModifying>> *pendingAsynchronousModifications =
  @[
    // Insert section 0
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedSections:[NSIndexSet indexSetWithIndex:0]]
      build]
     stateListener:nil
     userInfo:nil],
    // Insert two items into section 0
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedItems:@{
                           [NSIndexPath indexPathForItem:0 inSection:0]: @"A1",
                           [NSIndexPath indexPathForItem:1 inSection:0]: @"B1",
                           }]
      build]
     stateListener:nil
     userInfo:nil],
    // Insert section 1
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedSections:[NSIndexSet indexSetWithIndex:1]]
      build]
     stateListener:nil
     userInfo:nil],
    // Insert two items into section 1
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedItems:@{
                           [NSIndexPath indexPathForItem:0 inSection:1]: @"A2",
                           [NSIndexPath indexPathForItem:1 inSection:1]: @"B2",
                           }]
      build]
     stateListener:nil
     userInfo:nil],
    ];
  // Remove first item from each section
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:0 inSection:0],
                                           [NSIndexPath indexPathForItem:0 inSection:1],
                                           ]]]
   build];
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, pendingAsynchronousModifications) target:kChangeSetValid];
}

- (void)test_invalidChangesetAppliedToValidPendingAsynchronousModifications
{
  CKDataSourceState *state =
  [[CKDataSourceState alloc] initWithConfiguration:nil
                                                                sections:@[]];
  NSArray<id<CKDataSourceStateModifying>> *pendingAsynchronousModifications =
  @[
    // Insert section 0
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedSections:[NSIndexSet indexSetWithIndex:0]]
      build]
     stateListener:nil
     userInfo:nil],
    // Insert two items into section 0
    [[CKDataSourceChangesetModification alloc]
     initWithChangeset:
     [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
       withInsertedItems:@{
                           [NSIndexPath indexPathForItem:0 inSection:0]: @"A1",
                           [NSIndexPath indexPathForItem:1 inSection:0]: @"B1",
                           }]
      build]
     stateListener:nil
     userInfo:nil],
    ];
  // Remove first item from section 1
  CKDataSourceChangeset *changeset =
  [[[CKDataSourceChangesetBuilder transactionalComponentDataSourceChangeset]
    withRemovedItems:[NSSet setWithArray:@[
                                           [NSIndexPath indexPathForItem:0 inSection:0],
                                           [NSIndexPath indexPathForItem:0 inSection:1],
                                           ]]]
   build];
  CKInvalidChangesetInfo target = { CKInvalidChangesetOperationTypeRemoveRow, 1, 0 };
  [self assertEqualChangesetInfoWith:CKIsValidChangesetForState(changeset, state, pendingAsynchronousModifications) target:target];
}


static const CKInvalidChangesetInfo kChangeSetValid = { CKInvalidChangesetOperationTypeNone, -1, -1};

static CKDataSourceItem *itemWithModel(id model)
{
  return [[CKDataSourceItem alloc] initWithRootLayout:{}
                                                model:model
                                            scopeRoot:nil
                                      boundsAnimation:{}];
}

@end
