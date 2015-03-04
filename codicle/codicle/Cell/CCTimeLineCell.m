//
//  CCTimeLineCell.m
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCTimeLineCell.h"
#import "CCCore.h"

@implementation CCTimeLineCell

- (void)awakeFromNib {
    // init
    _thumbnail.clipsToBounds = YES;
    _thumbnail.layer.cornerRadius = _thumbnail.frame.size.width/2.f;
    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.clipsToBounds = YES;
    _backGround.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
//    // shadow
//    if (MARGIN_ON) {
//        self.layer.shadowOpacity = 0.2;
//        self.layer.shadowRadius = 1.0;
//        self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += self.inset*2;
    frame.size.width -= 2 * self.inset*2;
    
    frame.origin.y += self.inset;
    frame.size.height -= 2 * self.inset;
    
    [super setFrame:frame];
}

- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath {
    
    if (_entry != entry) {
        _image.image = nil;
        _image.animatedImage = nil;
    }
    
    _entry = entry;
    __block __weak CCEntry *ccEntry = entry;
    
    //* article thumbnail
    // gif
    if ([ccEntry.thumbnailUrl hasSuffix:@".gif"]) {
        [CCCORE gifImageAtURL:entry.thumbnailUrl completion:^(FLAnimatedImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _image.image = image.posterImage;
                _image.animatedImage = image;
            });
        }];
    }
    // other
    else {
        [CCCORE imageAtURL:entry.thumbnailUrl completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _image.image = image;
            });
        }];
    }
    
    //* user icon
    [CCCORE imageAtURL:entry.usrImgUrl completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ccEntry == _entry) {
                _thumbnail.image = image;
            }
        });
    }];
    
    //* info
    _usrName.text = entry.usrName;
    _text.text = entry.title;
}


@end
