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
    _chkImage = [[UIImageView alloc] initWithFrame:CGRectMake(_imageView.frame.size.width-(_imageView.frame.size.width/4)-5, 5, _imageView.frame.size.width/4, _imageView.frame.size.width/4)];
    _chkImage.clipsToBounds = YES;
    _chkImage.layer.cornerRadius = _chkImage.frame.size.width/2;
    [[_chkImage layer] setBorderWidth:1.5f];
    [[_chkImage layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    _selectedImage.alpha = 0;
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_selectedImage];
    [self.contentView addSubview:_chkImage];
}


@end
