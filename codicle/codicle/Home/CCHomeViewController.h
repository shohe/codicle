//
//  CCHomeViewController.h
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCHomeViewController : CCBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray     *dataMary;
@end
