//
//  CCUserViewController.m
//  codicle
//
//  Created by SHOHE on 3/4/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCUserViewController.h"
#import "FXBlurView.h"


#define USER_INFO_FRAME 350
@interface CCUserViewController () {
    UIImageView     *_infoHeader;
    UIImageView     *_infoLove;
    UIImageView     *_infoBook;
    FXBlurView      *_infoHeaderBlur;
    CAGradientLayer *_gradient;
    CGRect          _infoHeaderFrame;
}

@end

@implementation CCUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableView init
    _table.contentInset = UIEdgeInsetsMake(USER_INFO_FRAME, 0, 0, 0);
    _table.scrollIndicatorInsets = UIEdgeInsetsMake(USER_INFO_FRAME, 0, 0, 0);
    
    
    // infoHeader init
    _infoHeader = [[UIImageView alloc] initWithFrame:
                   CGRectMake(0, -USER_INFO_FRAME-20, _CCWINDOWSIZE().width, USER_INFO_FRAME/2)];
    [_infoHeader setImage:[UIImage imageNamed:@"model.jpg"]];
    [_infoHeader setContentMode:UIViewContentModeScaleAspectFill];
    [_infoHeader setClipsToBounds:YES];
    [_table addSubview:_infoHeader];
    
    _infoHeaderFrame = _infoHeader.frame;
    
    _infoHeaderBlur = [[FXBlurView alloc] initWithFrame:_infoHeaderFrame];
    [_infoHeaderBlur setTintColor:[UIColor whiteColor]];
    [_infoHeaderBlur setBlurRadius:8.f];
    [_infoHeaderBlur setAlpha:0];
    [_table addSubview:_infoHeaderBlur];
    
    
    // thumbnail init
    _thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(_infoHeaderFrame.size.width/2-40,
                                                               -USER_INFO_FRAME+_infoHeaderFrame.size.height-60,
                                                               80,
                                                               80)];
    _thumbnail.clipsToBounds = YES;
    _thumbnail.layer.cornerRadius = _thumbnail.frame.size.width/2.f;
    [[_thumbnail layer] setMasksToBounds:YES];
    [[_thumbnail layer] setBorderWidth:2.f];
    [[_thumbnail layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [_thumbnail setImage:[UIImage imageNamed:@"TEST_IMG_USR.jpg"]];
    [_table addSubview:_thumbnail];
    
    
    // infoLove init
    _infoLove = [[UIImageView alloc] initWithFrame:CGRectMake(_infoHeaderFrame.size.width/5,
                                                              _thumbnail.frame.origin.y+40,
                                                              70,
                                                              70)];
    [_infoLove setImage:[UIImage imageNamed:@"love_360"]];
    [_table addSubview:_infoLove];
    
    
    // infoBook init
    _infoBook = [[UIImageView alloc] initWithFrame:CGRectMake(_infoHeaderFrame.size.width/5*3,
                                                              _thumbnail.frame.origin.y+40,
                                                              70,
                                                              70)];
    [_infoBook setImage:[UIImage imageNamed:@"book_360"]];
    [_table addSubview:_infoBook];
    
    
    // userName init
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                          _infoLove.frame.origin.y+75,
                                                          _CCWINDOWSIZE().width,
                                                          25)];
    [_userName setText:@"Shohe"];
    [_userName setTextAlignment:NSTextAlignmentCenter];
    [_table addSubview:_userName];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:.2f animations:^{
        [_infoHeaderBlur setAlpha:1];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*****************************************/
# pragma mark - ScrollView Delegate
/*****************************************/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offSetY = scrollView.contentOffset.y+USER_INFO_FRAME+20;
    CCLog(@"%f",offSetY);
    
    if (offSetY <= 0) {
        [_infoHeader setFrame:CGRectMake(_infoHeaderFrame.origin.x+offSetY/2,
                                         _infoHeaderFrame.origin.y+offSetY,
                                         _infoHeaderFrame.size.width-offSetY,
                                         _infoHeaderFrame.size.height-offSetY)];
    } else if (_infoHeaderFrame.size.height-offSetY <= 70) {
        [_infoHeader setFrame:CGRectMake(_infoHeaderFrame.origin.x,
                                         _infoHeaderFrame.origin.y+offSetY-105,
                                         _infoHeaderFrame.size.width,
                                         _infoHeaderFrame.size.height)];
    } else if (offSetY <= 5) {
        [_infoHeader setFrame:CGRectMake(_infoHeaderFrame.origin.x,
                                         _infoHeaderFrame.origin.y,
                                         _infoHeaderFrame.size.width,
                                         _infoHeaderFrame.size.height)];
    }
    [_infoHeaderBlur setFrame:_infoHeader.frame];
}

/*****************************************/
#pragma mark - UITableViewDelegate
/*****************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = @"text";
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
