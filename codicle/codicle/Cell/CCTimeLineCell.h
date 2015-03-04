//
//  CCTimeLineCell.h
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
#import "CCEntry.h"

@interface CCTimeLineCell : UITableViewCell

@property (strong, nonatomic) IBOutlet FLAnimatedImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *usrName;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIImageView *backGround;


@property (strong,nonatomic) CCEntry *entry;
@property (nonatomic) CGFloat inset;

- (void)setEntry:(CCEntry *)entry withIndexPath:(NSIndexPath *)indexPath;
@end
