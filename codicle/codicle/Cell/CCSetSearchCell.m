//
//  CCSetSearchCell.m
//  codicle
//
//  Created by SHOHE on 3/11/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCSetSearchCell.h"

@implementation CCSetSearchCell

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
    CCEntry *ccEntry = entry;
    
    //* info
    _setName.text = @"スカート";
    _infoLabel.text = [NSString stringWithFormat:@"%@ : 409 posts : 2 marks", ccEntry.usrName];
}

@end
