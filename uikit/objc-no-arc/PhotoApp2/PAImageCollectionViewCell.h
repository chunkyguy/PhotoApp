//
//  PAImageCollectionViewCell.h
//  PhotoApp2
//
//  Created by Sidharth Juyal on 27/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PAPhoto.h"

@interface PAImageCollectionViewCell : UICollectionViewCell
+ (NSString *)reuseIdentifier;
-(void)setPhoto:(PAPhoto *)photo resolution:(ImageResolution)resolution;
- (void)reloadImage;
@end
