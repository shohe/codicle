//
//  CCRootController.m
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCRootController.h"

@interface CCRootController ()

@end

@implementation CCRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize bbgSize = self.tabBar.frame.size;
//    UIImage *bbg = [UIImage imageNamed:@"bbg.png"];
    
    //* resize bbg
//    UIImage *resizeBbg;
//    UIGraphicsBeginImageContext(bbgSize);
//    [bbg drawInRect:CGRectMake(0, 0, bbgSize.width, bbgSize.height)];
//    resizeBbg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
//    [[UITabBar appearance] setBackgroundImage:bbg];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    CGSize imageSize = CGSizeMake(_CCWINDOWSIZE().width/4/3, _CCWINDOWSIZE().width/4/3);
    UIImageView *timeline = [[UIImageView alloc] initWithFrame:
                             CGRectMake(_CCWINDOWSIZE().width/4/2-imageSize.width/2,
                                        bbgSize.height/2-imageSize.height/2,
                                        imageSize.width,
                                        imageSize.height)];
    UIImageView *search = [[UIImageView alloc] initWithFrame:
                             CGRectMake(_CCWINDOWSIZE().width/4+_CCWINDOWSIZE().width/4/2-imageSize.width/2,
                                        bbgSize.height/2-imageSize.height/2,
                                        imageSize.width,
                                        imageSize.height)];
    UIImageView *user = [[UIImageView alloc] initWithFrame:
                           CGRectMake(_CCWINDOWSIZE().width/4*2+_CCWINDOWSIZE().width/4/2-imageSize.width/2,
                                      bbgSize.height/2-imageSize.height/2,
                                      imageSize.width,
                                      imageSize.height)];
    UIImageView *write = [[UIImageView alloc] initWithFrame:
                         CGRectMake(_CCWINDOWSIZE().width/4*3+_CCWINDOWSIZE().width/4/2-imageSize.width/2,
                                    bbgSize.height/2-imageSize.height/2,
                                    imageSize.width,
                                    imageSize.height)];
    
    timeline.image = [UIImage imageNamed:@"timeline.png"];
    search.image = [UIImage imageNamed:@"search.png"];
    user.image = [UIImage imageNamed:@"user.png"];
    write.image = [UIImage imageNamed:@"write.png"];
    
    [self.tabBar addSubview:timeline];
    [self.tabBar addSubview:search];
    [self.tabBar addSubview:user];
    [self.tabBar addSubview:write];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    switch ((long)item.tag)
    {
        case 0:
            CCCORE.lastTabIndex = (NSInteger*)(long)item.tag;
            break;
        case 1:
            CCCORE.lastTabIndex = (NSInteger*)(long)item.tag;
            break;
        case 2:
            CCCORE.lastTabIndex = (NSInteger*)(long)item.tag;
            break;
        case 3:break;
    }
    CCLog(@"%ld", (long)CCCORE.lastTabIndex);
}

@end
