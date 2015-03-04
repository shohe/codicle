//
//  CCSearchUserViewController.h
//  codicle
//
//  Created by SHOHE on 2/25/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCSearchUserViewController : CCBaseViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *table;
@end
