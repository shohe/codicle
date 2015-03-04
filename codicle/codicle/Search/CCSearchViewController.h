//
//  CCSearchViewController.h
//  codicle
//
//  Created by SHOHE on 2/11/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCSearchViewController : CCBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray     *usrDataMary;
@end
