//
//  CCUserViewController.m
//  codicle
//
//  Created by SHOHE on 3/4/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCUserViewController.h"
#import "FXBlurView.h"
#import "CCTimeLineCell.h"


#define USER_INFO_FRAME 350
@interface CCUserViewController () {
    UIImageView     *_infoHeader;
    UIImageView     *_infoLove;
    UIImageView     *_infoBook;
    UILabel         *_infoHeaderName;
    UILabel         *_cmLabel;
    UILabel         *_postsLabel;
    UILabel         *_followingLabel;
    UILabel         *_followerLabel;
    
    FXBlurView      *_infoHeaderBlur;
    CAGradientLayer *_gradient;
    CGRect          _infoHeaderFrame;
    CGRect          _infoHeaderNameFrame;
    
    UIColor         *marginCellColor;
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

    _infoHeaderFrame = _infoHeader.frame;
    
    _infoHeaderBlur = [[FXBlurView alloc] initWithFrame:_infoHeaderFrame];
    [_infoHeaderBlur setTintColor:[UIColor grayColor]];
    [_infoHeaderBlur setBlurRadius:8.f];
    [_infoHeaderBlur setAlpha:0];
    
    
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
    
    
    // infoLove init
    _infoLove = [[UIImageView alloc] initWithFrame:CGRectMake(_infoHeaderFrame.size.width/5,
                                                              _thumbnail.frame.origin.y+40,
                                                              70,
                                                              70)];
    [_infoLove setImage:[UIImage imageNamed:@"love_360"]];
    
    
    // infoBook init
    _infoBook = [[UIImageView alloc] initWithFrame:CGRectMake(_infoHeaderFrame.size.width/5*3,
                                                              _thumbnail.frame.origin.y+40,
                                                              70,
                                                              70)];
    [_infoBook setImage:[UIImage imageNamed:@"book_360"]];
    
    
    // userName init
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                          _infoLove.frame.origin.y+75,
                                                          _CCWINDOWSIZE().width,
                                                          25)];
    [_userName setText:@"Shohe"];
    [_userName setTextAlignment:NSTextAlignmentCenter];
    
    // infoHeaderName init
    _infoHeaderName = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                _infoHeaderFrame.size.height+75,
                                                                _CCWINDOWSIZE().width,
                                                                25)];
    [_infoHeaderName setText:@"Shohe"];
    [_infoHeaderName setTextColor:[UIColor whiteColor]];
    [_infoHeaderName setTextAlignment:NSTextAlignmentCenter];
    [_infoHeaderName setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.8f]];
    [_infoHeaderName setShadowOffset:CGSizeMake(0, 1)];
    [_infoHeaderName setAlpha:0];
    _infoHeaderNameFrame = _infoHeaderName.frame;
    
    
    // Label init
    _cmLabel = [[UILabel alloc] initWithFrame:
                CGRectMake(_CCWINDOWSIZE().width/6*1, -65, _CCWINDOWSIZE().width/6, 25)];
    _postsLabel = [[UILabel alloc] initWithFrame:
                   CGRectMake(_CCWINDOWSIZE().width/6*2, -65, _CCWINDOWSIZE().width/6, 25)];
    _followingLabel = [[UILabel alloc] initWithFrame:
                       CGRectMake(_CCWINDOWSIZE().width/6*3, -65, _CCWINDOWSIZE().width/6, 25)];
    _followerLabel = [[UILabel alloc] initWithFrame:
                      CGRectMake(_CCWINDOWSIZE().width/6*4, -65, _CCWINDOWSIZE().width/6, 25)];
    
    UILabel *_partition = [[UILabel alloc] initWithFrame:
                           CGRectMake(_cmLabel.frame.origin.x+_cmLabel.frame.size.width,
                                      _cmLabel.frame.origin.y,
                                      2, _cmLabel.frame.size.height)];
    
    [_cmLabel setText:@"154\ncm"];
    [_postsLabel setText:@"39\nPosts"];
    [_followingLabel setText:@"205\nFollowing"];
    [_followerLabel setText:@"281\nFollower"];
    [_partition setText:@"|"];
    
    [_cmLabel setFont:[UIFont systemFontOfSize:10]];
    [_postsLabel setFont:[UIFont systemFontOfSize:10]];
    [_followingLabel setFont:[UIFont systemFontOfSize:10]];
    [_followerLabel setFont:[UIFont systemFontOfSize:10]];
    [_partition setFont:[UIFont systemFontOfSize:10]];
    
    [_cmLabel setNumberOfLines:0];
    [_postsLabel setNumberOfLines:0];
    [_followingLabel setNumberOfLines:0];
    [_followerLabel setNumberOfLines:0];
    
    [_cmLabel setTextAlignment:NSTextAlignmentCenter];
    [_postsLabel setTextAlignment:NSTextAlignmentCenter];
    [_followingLabel setTextAlignment:NSTextAlignmentCenter];
    [_followerLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    // userProfiel init
    _userProfiel = [[UILabel alloc] initWithFrame:
                    CGRectMake(0, -USER_INFO_FRAME+45, _CCWINDOWSIZE().width, 50)];
    [_userProfiel setText:@"原宿と新宿にいるよ！\nもっともっとおしゃれになりたい〜"];
    [_userProfiel setNumberOfLines:0];
    [_userProfiel setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.8f]];
    [_userProfiel setShadowOffset:CGSizeMake(0, 1)];
    [_userProfiel setFont:[UIFont systemFontOfSize:13]];
    [_userProfiel setTextColor:[UIColor whiteColor]];
    [_userProfiel setTextAlignment:NSTextAlignmentCenter];
    
    
    // loveLabel init
    _loveLabel = [[UILabel alloc] initWithFrame:
                  CGRectMake(0, 12, _infoLove.frame.size.width, _infoLove.frame.size.height-10)];
    [_loveLabel setTextAlignment:NSTextAlignmentCenter];
    [_loveLabel setText:@"75"];
    [_infoLove addSubview:_loveLabel];
    
    
    // bookLabel init
    _bookLabel = [[UILabel alloc] initWithFrame:
                  CGRectMake(0, 8, _infoBook.frame.size.width, _infoBook.frame.size.height-10)];
    [_bookLabel setTextAlignment:NSTextAlignmentCenter];
    [_bookLabel setText:@"4"];
    [_infoBook addSubview:_bookLabel];
    
    
    // add
    [_table addSubview:_cmLabel];
    [_table addSubview:_postsLabel];
    [_table addSubview:_followingLabel];
    [_table addSubview:_followerLabel];
    [_table addSubview:_partition];
    
    [_table addSubview:_userName];
    [_table addSubview:_infoHeader];
    [_table addSubview:_infoHeaderBlur];
    [_table addSubview:_thumbnail];
    [_table addSubview:_infoLove];
    [_table addSubview:_infoBook];
    [_table addSubview:_userProfiel];
    [_infoHeaderBlur addSubview:_infoHeaderName];
    
    
    // table data init
    [self tableDataInit];
    
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

- (void) tableDataInit {
    // datasource
    _dataMary = [NSMutableArray array];
    
    // color setting
    self.view.backgroundColor = [UIColor whiteColor];
    marginCellColor = [UIColor colorWithRed:227.0f/255.0f green:230.0f/255.0f blue:237.0f/255.0f alpha:1];
    self.table.backgroundColor = marginCellColor;
    
    // delete footer line
    [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //* TEST
    [CCCORE loadTestDataWithCompletion:^(NSError *error, NSMutableArray *mary) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _dataMary = mary;
                [_table reloadData];
                CCLog(@"%@",_dataMary);
            });
        }
    }];
}


/*****************************************/
# pragma mark - ScrollView Delegate
/*****************************************/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offSetY = scrollView.contentOffset.y+USER_INFO_FRAME+20;
    
    if (offSetY <= 0) {
        [_infoHeader setFrame:CGRectMake(_infoHeaderFrame.origin.x+offSetY/2,
                                         _infoHeaderFrame.origin.y+offSetY,
                                         _infoHeaderFrame.size.width-offSetY,
                                         _infoHeaderFrame.size.height-offSetY)];
        
        [_infoHeaderName setAlpha:0];
        
    } else if (_infoHeaderFrame.size.height-offSetY <= 70) {
        [_infoHeader setFrame:CGRectMake(_infoHeaderFrame.origin.x,
                                         _infoHeaderFrame.origin.y+offSetY-105,
                                         _infoHeaderFrame.size.width,
                                         _infoHeaderFrame.size.height)];

        [_infoHeaderName setFrame:CGRectMake(0,
                                             _infoHeaderNameFrame.origin.y-(offSetY-105),
                                             _infoHeaderNameFrame.size.width,
                                             _infoHeaderNameFrame.size.height)];
        [_infoHeaderName setAlpha:1];
        
    } else if (offSetY <= 5) {
        [_infoHeader setFrame:CGRectMake(_infoHeaderFrame.origin.x,
                                         _infoHeaderFrame.origin.y,
                                         _infoHeaderFrame.size.width,
                                         _infoHeaderFrame.size.height)];
    }
    
    // infoHeaderName
    if (offSetY >= 222) {
        [_infoHeaderName setFrame:CGRectMake(0,
                                             132,
                                             _infoHeaderNameFrame.size.width,
                                             _infoHeaderNameFrame.size.height)];
    }
    
    [_infoHeaderBlur setFrame:_infoHeader.frame];
}

/*****************************************/
#pragma mark - UITableViewDelegate
/*****************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataMary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"CCTimeLineCell";
    CCTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CCTimeLineCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.inset = MARGIN_ON ? 7.5 : 0;
    [cell setEntry:[_dataMary objectAtIndex:indexPath.row] withIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCEntry *entry = [_dataMary objectAtIndex:indexPath.row];
    NSString *text = entry.title;
    // left margin 20 + right margin 20 = 40
    CGSize maxSize = CGSizeMake(_CCWINDOWSIZE().width - 40, CGFLOAT_MAX);
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize modifiedSize = [text boundingRectWithSize:maxSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attr
                                             context:nil].size;
    
    return _CCWINDOWSIZE().width + 115 + modifiedSize.height*1.2;
}


@end
