//
//  CCPostPostViewController.m
//  codicle
//
//  Created by SHOHE on 3/20/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostPostViewController.h"
#import "CCPostFlowController.h"
#import "FLAnimatedImageView.h"

@interface CCPostPostViewController () {
    UIScrollView *_scrollView;
    UIView *_postViewFrame;
    CGPoint _originPoint;
    CGPoint _touchPoint;
    
    FLAnimatedImageView *_postImageView;
}

@end

@implementation CCPostPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // init view
    self.navigationController.view.backgroundColor = _CCColor();
    UIColor *alphaCollor = [_CCColor() colorWithAlphaComponent:.1f];
    
    self.navigationController.view.backgroundColor = alphaCollor;
    self.navigationController.navigationBar.backgroundColor = [_CCColor() colorWithAlphaComponent:.97f];
    self.view.backgroundColor = alphaCollor;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _CCWINDOWSIZE().width, 20)];
    header.backgroundColor = [_CCColor() colorWithAlphaComponent:.97f];
    [self.navigationController.view addSubview:header];
    
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // right button
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"Post"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(pushPost)];
    postBtn.tintColor = _CCBlueColor();
    self.navigationItem.rightBarButtonItem = postBtn;
    
    
    [self setScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushPost {
//    // animation
//    [UIView animateWithDuration:.3f animations:^{
//        [_postViewFrame setCenter:CGPointMake(_originPoint.x, _originPoint.y+10)];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            [_postViewFrame setCenter:CGPointMake(_originPoint.x, _postViewFrame.frame.size.height*-1)];
//        } completion:^(BOOL finished) {
//            CCLog(@"TODO: post to server method");
//            [_delegate didPostCancel];
//        }];
//    }];
    
    // no animation
    CCLog(@"TODO: post to server method");
    [_delegate didPostCancel];
}

//- (void)createPostViewFrame {
//    UIImage *image = _selectImages[0];
//    float height = image.size.height*_CCWINDOWSIZE().width/image.size.width;
//    _postViewFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 79, _CCWINDOWSIZE().width, height+100)];
//    _postViewFrame.backgroundColor = [UIColor whiteColor];
//    _originPoint = _postViewFrame.center;
//    [self.view addSubview:_postViewFrame];
//    
//    _postImageView = [[FLAnimatedImageView alloc] initWithFrame: CGRectMake(0, 0, _CCWINDOWSIZE().width, height)];
//    _postImageView.backgroundColor = _CCBlueColor();
//    
//    // normal
//    if ([_selectImages count] < 2) {
//        _postImageView.image = _selectImages[0];
//    }
//    // gif
//    else {
//        _postImageView.image = _selectImages[0];
//    }
//    
//    [_postViewFrame addSubview:_postImageView];
//}
- (void)setScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:
                   CGRectMake(0, 59, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-39)];
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(-59, 0, 0, 0);
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
}

- (void)createScrollView {
    UIImage *image = _selectImages[0];
    float height = image.size.height*_CCWINDOWSIZE().width/image.size.width;
    _postViewFrame = [[UIView alloc] initWithFrame:CGRectMake(0, -39, _CCWINDOWSIZE().width, height+100)];
    _postViewFrame.backgroundColor = [UIColor whiteColor];
    
    _scrollView.contentSize = _postViewFrame.frame.size;
    [_scrollView addSubview:_postViewFrame];
}

@end
