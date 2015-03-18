//
//  CCChannelSearchCell.h
//  codicle
//
//  Created by SHOHE on 3/18/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCEntry.h"

@interface CCChannelSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong,nonatomic) CCEntry *entry;

- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath;

@end
