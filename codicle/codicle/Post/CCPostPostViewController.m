//
//  CCPostPostViewController.m
//  codicle
//
//  Created by SHOHE on 3/20/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostPostViewController.h"
#import "CCPostFlowController.h"

@interface CCPostPostViewController () {
    UIView *_postViewFrame;
    CGPoint _originPoint;
    CGPoint _touchPoint;
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
    
    [self createPostViewFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushPost {
    [UIView animateWithDuration:.3f animations:^{
        [_postViewFrame setCenter:CGPointMake(_originPoint.x, _originPoint.y+10)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_postViewFrame setCenter:CGPointMake(_originPoint.x, _postViewFrame.frame.size.height*-1)];
        } completion:^(BOOL finished) {
            CCLog(@"TODO: post to server method");
            [_delegate didPostCancel];
        }];
    }];
}

- (void)createPostViewFrame {
    _postViewFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 79, _CCWINDOWSIZE().width, _CCWINDOWSIZE().width+100)];
    _postViewFrame.backgroundColor = [UIColor whiteColor];
    _originPoint = _postViewFrame.center;
    [self.view addSubview:_postViewFrame];
    
    UIView *testImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _CCWINDOWSIZE().width, _CCWINDOWSIZE().width)];
    testImageView.backgroundColor = _CCBlueColor();
    [_postViewFrame addSubview:testImageView];
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _touchPoint = [((UITouch*)[touches anyObject])locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [((UITouch*)[touches anyObject])locationInView:self.view];
    float moveY = (point.y-_touchPoint.y)*.5f;
    [_postViewFrame setCenter:CGPointMake(_originPoint.x, _originPoint.y+moveY)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_postViewFrame setCenter:CGPointMake(_originPoint.x, _originPoint.y-3)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1f animations:^{
            [_postViewFrame setCenter:_originPoint];
        }];
    }];
}

@end
