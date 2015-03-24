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

@interface CCPostPostViewController ()<UITextFieldDelegate> {
    UIScrollView *_scrollView;
    
    UIView *_postViewFrame;
    FLAnimatedImageView *_postImageView;
    UITextField *_textField;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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

- (void)setScrollView {
    [self setPostView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:
                   CGRectMake(0, 59, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-39)];
    _scrollView.contentSize = _postViewFrame.frame.size;
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(-59, 0, 20, 0);
    _scrollView.alwaysBounceVertical = YES;
    [_scrollView addSubview:_postViewFrame];
    [self.view addSubview:_scrollView];
}

- (void)setPostView {
    [self setImageView];
    [self setTextField];
    
    _postViewFrame = [[UIView alloc] initWithFrame:
                      CGRectMake(0, -39, _CCWINDOWSIZE().width, _postImageView.frame.size.height+100)];
    _postViewFrame.backgroundColor = [UIColor whiteColor];
    [_postViewFrame addSubview:_postImageView];
    [_postViewFrame addSubview:_textField];
}

- (void)setImageView {
    UIImage *image = _selectImages[0];
    float height = image.size.height*_CCWINDOWSIZE().width/image.size.width;
    _postImageView = [[FLAnimatedImageView alloc] initWithFrame: CGRectMake(0, 0, _CCWINDOWSIZE().width, height)];
    // normal
    if ([_selectImages count] < 2) {
        _postImageView.image = _selectImages[0];
    }
    // gif
    else {
        _postImageView.backgroundColor = _CCBlueColor();
    }
}

- (void)setTextField {
    _textField = [[UITextField alloc] initWithFrame:
                  CGRectMake(10, _postImageView.frame.size.height+10, _CCWINDOWSIZE().width-20, 30)];
    _textField.delegate = self;
    _textField.placeholder = @"Caption";
    _textField.backgroundColor = _CCBlueColor();
}

- (void)keyboardWillShown:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [_postViewFrame convertRect:keyboardRect fromCoordinateSpace:nil];
    
    CGFloat underScrollView = _scrollView.contentSize.height+_scrollView.frame.origin.y;
    CGFloat movePosition = 0;
    if (keyboardRect.origin.y < underScrollView) {
        movePosition = underScrollView - keyboardRect.origin.y - 20;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [_scrollView setFrame:CGRectMake(_scrollView.frame.origin.x,
                                     _scrollView.frame.origin.y,
                                     _scrollView.frame.size.width,
                                     _scrollView.frame.size.height-keyboardRect.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, movePosition) animated:NO];
    [UIView commitAnimations];
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [_scrollView setFrame:CGRectMake(0, 59, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-39)];
    _scrollView.contentSize = _postViewFrame.frame.size;
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(-59, 0, 20, 0);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}

@end
