//
//  CCPostViewController.m
//  codicle
//
//  Created by SHOHE on 3/18/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostViewController.h"

@interface CCPostViewController ()

@end

@implementation CCPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    self.tabBarController.selectedIndex = (long)CCCORE.lastTabIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
