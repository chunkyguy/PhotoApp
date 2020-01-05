//
//  PATitleCollectionSupplementaryView.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 09/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PAPhoto;

@interface PATitleCollectionSupplementaryView : UICollectionReusableView
+ (NSString *)reuseIdentifier;
- (void)setPhoto:(PAPhoto *)photo;
@end
