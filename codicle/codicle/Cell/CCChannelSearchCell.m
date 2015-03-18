//
//  CCChannelSearchCell.m
//  codicle
//
//  Created by SHOHE on 3/18/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCChannelSearchCell.h"

@implementation CCChannelSearchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath {
    
    if (_entry != entry) {
        //_backGround.image = nil;
    }
    
    _entry = entry;
    __block __weak CCEntry *ccEntry = entry;
    
    [CCCORE imageAtURL:entry.usrImgUrl completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ccEntry == _entry) {
                _thumbnail.image = image;
            }
        });
    }];
    
    _title.text = @"チャンネル名";
    _infoLabel.text = @"今時なんとかの原宿系モードなんとかのお得な情報もあるチャンネルです！";
}


@end
