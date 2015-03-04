//
//  CCSearchCell.h
//  codicle
//
//  Created by SHOHE on 2/25/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCEntry.h"

@interface CCSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backGround;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *post;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;


@property (strong,nonatomic) CCEntry *entry;
@property (nonatomic) CGFloat inset;

- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath;
@end
