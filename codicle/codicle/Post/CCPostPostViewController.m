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
#import "UIPlaceHolderTextView.h"
#import "YAPGif.h"

@interface CCPostPostViewController ()<UIGestureRecognizerDelegate, UITextViewDelegate> {
    UIScrollView *_scrollView;
    
    UIView *_postViewFrame;
    UIView *_userInfoView;
    UIImageView *_postImageView;
    UIPlaceHolderTextView *_textField;
    UITapGestureRecognizer *_singleTap;
    BOOL _isAnimKeyboard;
    CGRect _keyboardRect;
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
    
    // set gesture
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    _singleTap.delegate = self;
    _singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:_singleTap];
    _isAnimKeyboard = YES;
    
    [self setScrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShownInputMode:) name:UITextInputCurrentInputModeDidChangeNotification object:nil];
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
    if (_textField.isFirstResponder) {
        [_textField resignFirstResponder];
    }
    [_delegate didPostCancel];
}

- (void)setScrollView {
    [self setPostView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:
                   CGRectMake(0, 59, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-39)];
    _scrollView.contentSize = CGSizeMake(_CCWINDOWSIZE().width,
                                         _postViewFrame.frame.size.height+_userInfoView.frame.size.height);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(-59, 0, 20, 0);
    _scrollView.alwaysBounceVertical = YES;
    [_scrollView addSubview:_postViewFrame];
    [self.view addSubview:_scrollView];
}

- (void)setPostView {
    [self setImageView];
    [self setTextField];
    
    _postViewFrame = [[UIView alloc] initWithFrame:CGRectMake(0, -39, _CCWINDOWSIZE().width,
                                                              _postImageView.frame.size.height+
                                                              _textField.frame.size.height+20)];
    _postViewFrame.backgroundColor = [UIColor whiteColor];
    [_postViewFrame addSubview:_postImageView];
    [_postViewFrame addSubview:_textField];
    [self setUserInfo];
}

- (void)setImageView {
    UIImage *image = _selectImages[0];
    float height = image.size.height*_CCWINDOWSIZE().width/image.size.width;
    _postImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, _CCWINDOWSIZE().width, height)];
    // normal
    if ([_selectImages count] < 2) {
        _postImageView.image = _selectImages[0];
    }
    // gif
    else {
        _postImageView.image = [self exportAnimatedGif:_selectImages].image;
    }
}

- (YAPGif *)exportAnimatedGif:(NSArray *)images {
    YAPGif *gif  = [[YAPGif alloc]initWithImages:images];
    gif.delay    = [NSNumber numberWithFloat:.5f];
    
    return gif;
}

- (void)setTextField {
    _textField = [[UIPlaceHolderTextView alloc] initWithFrame:
                  CGRectMake(10, _postImageView.frame.size.height+15, _CCWINDOWSIZE().width-20, 17)];
    _textField.delegate = self;
    _textField.textContainer.lineFragmentPadding = 0;
    _textField.textContainerInset = UIEdgeInsetsMake(0, 0, -6, 0);
    _textField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:15];
    _textField.tintColor = _CCBlueColor();
    _textField.layoutManager.allowsNonContiguousLayout = NO;
    _textField.placeholder = @"Caption";
}

- (void)setUserInfo {
    // img
    UIImageView *thumbnail = [[UIImageView alloc] initWithFrame: CGRectMake(_textField.frame.origin.x, 15, 30, 30)];
    thumbnail.clipsToBounds = YES;
    thumbnail.layer.cornerRadius = thumbnail.frame.size.width/2;
    thumbnail.image = [UIImage imageNamed:@"TEST_IMG_USR.jpg"];
    
    UIImageView *mark = [[UIImageView alloc] initWithFrame:
                         CGRectMake(_textField.frame.origin.x+_textField.frame.size.width-30,
                                    thumbnail.frame.origin.y+thumbnail.frame.size.height-21, 30, 21)];
    if ([_selectImages count] > 1 || _isGif) {
        mark.image = [UIImage imageNamed:@"gif_icon"];
    } else {
        mark.image = [UIImage imageNamed:@"photo_icon"];
    }
    
    // label
    UILabel *name = [[UILabel alloc] init];
    name.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
    [name setText:@"Mr.Test1"];
    [name sizeToFit];
    [name setFrame:CGRectMake(thumbnail.frame.origin.x+thumbnail.frame.size.width+10,
                               thumbnail.center.y-name.frame.size.height/2,
                               name.frame.size.width,
                               name.frame.size.height)];
    
    // infoView
    _userInfoView = [[UIView alloc] initWithFrame:CGRectMake(_postViewFrame.frame.origin.x,
                                                             _postViewFrame.frame.size.height,
                                                             _postViewFrame.frame.size.width, 60)];
    _userInfoView.backgroundColor = [UIColor whiteColor];
    
    // add
    [_userInfoView addSubview:thumbnail];
    [_userInfoView addSubview:mark];
    [_userInfoView addSubview:name];
    [_postViewFrame addSubview:_userInfoView];
}

- (void)keyboardWillShown:(NSNotification *)notification {
    if (_isAnimKeyboard) {
        NSDictionary *userInfo = [notification userInfo];
        _keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _keyboardRect = [_postViewFrame convertRect:_keyboardRect fromCoordinateSpace:nil];
        
        CGFloat underScrollView = _scrollView.contentSize.height+_scrollView.frame.origin.y;
        CGFloat movePosition = 0;
        if (_keyboardRect.origin.y < underScrollView) {
            movePosition = underScrollView - _keyboardRect.origin.y - 20;
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
        [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [_scrollView setFrame:CGRectMake(_scrollView.frame.origin.x,
                                         _scrollView.frame.origin.y,
                                         _scrollView.frame.size.width,
                                         _scrollView.frame.size.height-_keyboardRect.size.height)];

        [_scrollView setContentOffset:CGPointMake(0, movePosition) animated:NO];
        [UIView commitAnimations];
        _isAnimKeyboard = NO;
    }
}

//- (void)keyboardWillShownInputMode:(NSNotification *)notification {
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
//    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [_scrollView setFrame:CGRectMake(_scrollView.frame.origin.x,
//                                     _scrollView.frame.origin.y+35,
//                                     _scrollView.frame.size.width,
//                                     _scrollView.frame.size.height-keyboardRect.size.height-35)];
//
//    [_scrollView setContentOffset:CGPointMake(0, movePosition) animated:NO];
//    [UIView commitAnimations];
//}

- (void)keyboardWillHidden:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [_scrollView setFrame:CGRectMake(0, 59, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-39)];
    
    _scrollView.contentSize = CGSizeMake(_CCWINDOWSIZE().width,
                                         _postViewFrame.frame.size.height+_userInfoView.frame.size.height);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 20, 0);
    [UIView commitAnimations];
    _isAnimKeyboard = YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [textView setContentOffset:textView.contentOffset animated:NO];
    CGRect f = textView.frame;
    f.size.height = textView.contentSize.height;
    textView.frame = f;
    
    [_postViewFrame setFrame:CGRectMake(_postViewFrame.frame.origin.x,
                                        _postViewFrame.frame.origin.y,
                                        _postViewFrame.frame.size.width,
                                        _postImageView.frame.size.height+_textField.frame.size.height+20)];
    [_userInfoView setFrame:CGRectMake(_userInfoView.frame.origin.x,
                                       _postViewFrame.frame.size.height,
                                       _userInfoView.frame.size.width,
                                       _userInfoView.frame.size.height)];
    
    _scrollView.contentSize = CGSizeMake(_CCWINDOWSIZE().width,
                                         _postViewFrame.frame.size.height+_userInfoView.frame.size.height);
    
    CGFloat underScrollView = _scrollView.contentSize.height+_scrollView.frame.origin.y;
    CGFloat movePosition = 0;
    if (_keyboardRect.origin.y < underScrollView) {
        movePosition = underScrollView - _keyboardRect.origin.y - 20;
    }
    [_scrollView setContentOffset:CGPointMake(0, movePosition) animated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [_textField resignFirstResponder];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == _singleTap) {
        if (_textField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

@end
