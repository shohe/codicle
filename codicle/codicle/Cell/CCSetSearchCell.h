//
//  CCSetSearchCell.h
//  codicle
//
//  Created by SHOHE on 3/11/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCEntry.h"

@interface CCSetSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *setName;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;

@property (strong,nonatomic) CCEntry *entry;

- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath;
@end
