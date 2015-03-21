//
//  CCCameraRollCell.h
//  codicle
//
//  Created by SHOHE on 3/21/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCameraRollCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImageView *selectedImage;
@property (strong,nonatomic) UIView *maskView;
@property NSIndexPath *indexPath;

@end
