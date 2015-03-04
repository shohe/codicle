//
//  CCSearchCell.m
//  codicle
//
//  Created by SHOHE on 2/25/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCSearchCell.h"

@implementation CCSearchCell

- (void)awakeFromNib {
    // init
    _thumbnail.clipsToBounds = YES;
    _thumbnail.layer.cornerRadius = _thumbnail.frame.size.width/2.f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath {
    
    if (_entry != entry) {
        _backGround.image = nil;
    }
    
    _entry = entry;
    __block __weak CCEntry *ccEntry = entry;
    
    //* user icon
    [CCCORE imageAtURL:entry.usrImgUrl completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ccEntry == _entry) {
                _thumbnail.image = image;
            }
        });
    }];
    
    //* info
    _userName.text = entry.usrName;
    _post.text = [NSString stringWithFormat:@"%i Posts", 30];
}

@end
