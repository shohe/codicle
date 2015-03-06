//
//  CCUserViewController.h
//  codicle
//
//  Created by SHOHE on 3/4/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCUserViewController : CCBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong) UIImageView *thumbnail;
@property (strong) UILabel *userName;
@property (strong) UILabel *userProfiel;
@property (strong) UILabel *loveLabel;
@property (strong) UILabel *bookLabel;
@property (nonatomic, strong) NSMutableArray *dataMary;

@end
