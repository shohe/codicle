//
//  CCCameraRollCell.m
//  codicle
//
//  Created by SHOHE on 3/21/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCCameraRollCell.h"

@implementation CCCameraRollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (_CCWINDOWSIZE().width-10*4)/3, (_CCWINDOWSIZE().width-10*4)/3)];
    _selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (_CCWINDOWSIZE().width-10*4)/3, (_CCWINDOWSIZE().width-10*4)/3)];
    _selectedImage.alpha = 0;
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_selectedImage];
}


@end
