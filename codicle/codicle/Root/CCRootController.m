//
//  CCRootController.m
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCRootController.h"
#import "CCPostFlowController.h"

@interface CCRootController () <CCPostFlowDelegate>{
    UIButton *_photoBtn;
    UIButton *_videoBtn;
}

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
    
    
    
    // postView init
    _postView = [[UIView alloc] initWithFrame:self.view.bounds];
    _postView.backgroundColor = _CCColor();
    _postView.alpha = 0;
    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _CCWINDOWSIZE().height, _CCWINDOWSIZE().width, 49)];
    _cancelBtn.backgroundColor = _CCBtnColor();
    [_cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelPostView) forControlEvents:UIControlEventTouchUpInside];
    [_postView addSubview:_cancelBtn];
    [self.view addSubview:_postView];
    
    // button init
    _photoBtn = [[UIButton alloc] initWithFrame:
                 CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, _CCWINDOWSIZE().height, 80, 80)];
    _videoBtn = [[UIButton alloc] initWithFrame:
                 CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, _CCWINDOWSIZE().height, 80, 80)];
    
    _photoBtn.clipsToBounds = YES;
    _photoBtn.tag = 0;
    _photoBtn.layer.cornerRadius = _photoBtn.frame.size.width/2.f;
    _videoBtn.clipsToBounds = YES;
    _videoBtn.tag = 1;
    _videoBtn.layer.cornerRadius = _videoBtn.frame.size.width/2.f;
    
    _photoBtn.backgroundColor = [UIColor purpleColor];
    _videoBtn.backgroundColor = [UIColor purpleColor];
    
    [_photoBtn addTarget:self action:@selector(displayCollectionView:) forControlEvents:UIControlEventTouchUpInside];
    [_videoBtn addTarget:self action:@selector(displayCollectionView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_postView addSubview:_photoBtn];
    [_postView addSubview:_videoBtn];
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
        case 3:
            [self displayPostView];
            break;
    }

}


- (void)displayPostView {
    _postView.alpha = .9f;
    [self performSelector:@selector(photoStartAnim) withObject:nil];
    [self performSelector:@selector(videoStartAnim) withObject:nil afterDelay:.07f];
    [self performSelector:@selector(cancelBtnStartAnim) withObject:nil afterDelay:.2f];
}


- (void)cancelPostView {
    [UIView animateWithDuration:.2 animations:^{
        _photoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, -80, 80, 80);
        _videoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, -80, 80, 80);
        _cancelBtn.frame = CGRectMake(0, _CCWINDOWSIZE().height, _CCWINDOWSIZE().width, 49);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            _postView.alpha = 0;
        }];
        _photoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, _CCWINDOWSIZE().height, 80, 80);
        _videoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, _CCWINDOWSIZE().height, 80, 80);
    }];
}


//* anim
- (void)photoStartAnim {
    [UIView animateWithDuration:.2 animations:^{
        _photoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, _CCWINDOWSIZE().height/2-40-15, 80, 80);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.15 animations:^{
            _photoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, _CCWINDOWSIZE().height/2-40, 80, 80);
        }];
    }];
}

- (void)videoStartAnim {
    [UIView animateWithDuration:.2 animations:^{
        _videoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, _CCWINDOWSIZE().height/2-40-15, 80, 80);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.15 animations:^{
            _videoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, _CCWINDOWSIZE().height/2-40, 80, 80);
        }];
    }];
}

- (void)cancelBtnStartAnim {
    [UIView animateWithDuration:.2 animations:^{
        _cancelBtn.frame = CGRectMake(0, _CCWINDOWSIZE().height-49, _CCWINDOWSIZE().width, 49);
    }];
}

- (void)displayCollectionView:(id)sender {
    UIButton *button = (UIButton*)sender;
    UINavigationController *nc = [[self storyboard] instantiateViewControllerWithIdentifier:@"PostNaviController"];
    nc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    CCPostFlowController *postFlowController = nc.childViewControllers[0];
    postFlowController.delegate = self;
    
    if (button.tag == 0) {
        [CCCORE loadCameraRollListIsPhoto:YES WithCompletion:^(NSError *error, NSArray *mary) {
            if (!error && [mary count] > 0) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *data in [mary reverseObjectEnumerator]) {
                    [array addObject:data];
                }
                postFlowController.datasource = array;
                [self presentViewWithAnim:nc];
            }
        }];
    } else {
        [CCCORE loadCameraRollListIsPhoto:NO WithCompletion:^(NSError *error, NSArray *mary) {
            if (!error && [mary count] > 0) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *data in [mary reverseObjectEnumerator]) {
                    [array addObject:data];
                }
                postFlowController.datasource = array;
                [self presentViewWithAnim:nc];
            }
        }];
    }
    
    
}

- (void)presentViewWithAnim:(UIViewController*)viewController {
    [UIView animateWithDuration:.2 animations:^{
        _photoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, -80, 80, 80);
        _videoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, -80, 80, 80);
        _cancelBtn.frame = CGRectMake(0, _CCWINDOWSIZE().height, _CCWINDOWSIZE().width, 49);
    } completion:^(BOOL finished) {
        _photoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*1-40+10, _CCWINDOWSIZE().height, 80, 80);
        _videoBtn.frame = CGRectMake(_CCWINDOWSIZE().width/4*3-40-10, _CCWINDOWSIZE().height, 80, 80);
        [self presentViewController:viewController animated:NO completion:nil];
    }];
}


#pragma mark - CCPostFlowDelegate
- (void)didPostCancel {
    [UIView animateWithDuration:.5f animations:^{
        _postView.alpha = 0;
    }];
}

@end


