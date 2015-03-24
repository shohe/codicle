//
//  CCPostNavigationController.m
//  codicle
//
//  Created by SHOHE on 3/24/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostNavigationController.h"

@interface CCPostNavigationController ()

@end

@implementation CCPostNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIView *theWindow = self.view;
    if (animated) {
        CATransition *animation = [CATransition animation];
        [animation setDuration:.4f];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[theWindow layer] addAnimation:animation forKey:@""];
    } else {
        [super pushViewController:viewController animated:NO];
    }
    [super pushViewController:viewController animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
