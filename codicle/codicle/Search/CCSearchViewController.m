//
//  CCSearchViewController.m
//  codicle
//
//  Created by SHOHE on 2/11/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCSearchViewController.h"
#import "CCSearchCell.h"
#import "CCTitleSearchCell.h"
#import "CCSetSearchCell.h"
#import "CCChannelSearchCell.h"
#import "FXBlurView.h"

@interface CCSearchViewController () {
    UIView *_pushedSearchBtn;
    UIView *_pushedBtnBorder;
    UIView *_searchBackground;
    
    UISearchBar *_searchBar;
    
    CGRect USER_BUTTON_FRAME;
    CGRect TITLE_BUTTON_FRAME;
    CGRect BOUQUET_BUTTON_FRAME;
    CGRect CHANNEL_BUTTON_FRAME;
    
    int SEARCH_STATE;
    enum {
        USER_SEARCH,
        TITLE_SEARCH,
        BOUQUET_SEARCH,
        CHANNEL_SEARCH
    };
}

@end

@implementation CCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableview footer margin
    self.table.contentInset =
    (MARGIN_ON) ? UIEdgeInsetsMake(110, 0, 7.5, 0) : UIEdgeInsetsMake(0, 0, 49.0, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(90, 0, 0, 0);
    
    // test
    _table.alpha = .8f;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                              CGRectMake(0, 90, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-90)];
    imageView.image = [UIImage imageNamed:@"model.jpg"];
    FXBlurView *_infoHeaderBlur = [[FXBlurView alloc] initWithFrame:
                                   CGRectMake(0, 0, _CCWINDOWSIZE().width, _CCWINDOWSIZE().height-90)];
    [_infoHeaderBlur setBlurRadius:8.f];
    [imageView addSubview:_infoHeaderBlur];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    // datasource
    _usrDataMary = [NSMutableArray array];
    
    // search button init.
    [self initSearchButton];
    
    // searchBar init.
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 30, _CCWINDOWSIZE().width-40, 30)];
    [_searchBar setBackgroundImage: [UIImage imageNamed: @"clearBack.png"]];
    [_searchBar setPlaceholder:@"keyword"];
    [_searchBackground addSubview:_searchBar];
    
    //* TEST
    [CCCORE loadTestDataWithCompletion:^(NSError *error, NSMutableArray *mary) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _usrDataMary = mary;
                [_table reloadData];
                CCLog(@"%@",_usrDataMary);
            });
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSearchButton {
    
    _searchBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _CCWINDOWSIZE().width, 130.f)];
    _searchBackground.backgroundColor = _CCColor();
    _searchBackground.alpha = 0.9f;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, _searchBackground.frame.size.height, _searchBackground.frame.size.width, 2.0f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [_searchBackground.layer addSublayer:bottomBorder];
    
    float space = 20.f;
    float btnPosY = _searchBackground.frame.size.height/5*3;
    CGSize btnSize = CGSizeMake((_CCWINDOWSIZE().width - space*5)/4, 30.f);
    
    USER_BUTTON_FRAME = CGRectMake(btnSize.width*0 + space*1, btnPosY, btnSize.width, btnSize.height);
    TITLE_BUTTON_FRAME = CGRectMake(btnSize.width*1 + space*2, btnPosY, btnSize.width, btnSize.height);
    BOUQUET_BUTTON_FRAME = CGRectMake(btnSize.width*2 + space*3, btnPosY, btnSize.width, btnSize.height);
    CHANNEL_BUTTON_FRAME = CGRectMake(btnSize.width*3 + space*4, btnPosY, btnSize.width, btnSize.height);
    UIButton *userBtn = [[UIButton alloc] initWithFrame:USER_BUTTON_FRAME];
    UIButton *titleBtn = [[UIButton alloc] initWithFrame:TITLE_BUTTON_FRAME];
    UIButton *bouquetBtn = [[UIButton alloc] initWithFrame:BOUQUET_BUTTON_FRAME];
    UIButton *channelBtn = [[UIButton alloc] initWithFrame:CHANNEL_BUTTON_FRAME];
    
    _pushedSearchBtn = [[UIView alloc] initWithFrame:USER_BUTTON_FRAME];
    _pushedSearchBtn.backgroundColor = [UIColor colorWithRed:190.0f/255.0f green:193.0f/255.0f blue:200.0f/255.0f alpha:1];
    _pushedSearchBtn.layer.cornerRadius = _pushedSearchBtn.frame.size.height/2;
    _pushedSearchBtn.clipsToBounds = YES;
    
    _pushedBtnBorder = [[UIView alloc] initWithFrame:
                        CGRectMake(USER_BUTTON_FRAME.origin.x+USER_BUTTON_FRAME.size.width/2-1,
                                   USER_BUTTON_FRAME.origin.y+USER_BUTTON_FRAME.size.height, 2, 23)];
    [_pushedBtnBorder setBackgroundColor:[UIColor grayColor]];
    
    [userBtn setTitle:USER_BUTTON_TITLE forState:UIControlStateNormal];
    [titleBtn setTitle:TITLE_BUTTON_TITLE forState:UIControlStateNormal];
    [bouquetBtn setTitle:BOUQUET_BUTTON_TITLE forState:UIControlStateNormal];
    [channelBtn setTitle:CHANNEL_BUTTON_TITLE forState:UIControlStateNormal];
    
    [userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bouquetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [channelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    userBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:9.5];
    titleBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:9.5];
    bouquetBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:9.5];
    channelBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:9.5];
    
    [userBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    [titleBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    [bouquetBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    [channelBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:_searchBackground];
    [_searchBackground addSubview:_pushedBtnBorder];
    [_searchBackground addSubview:_pushedSearchBtn];
    [_searchBackground addSubview:userBtn];
    [_searchBackground addSubview:titleBtn];
    [_searchBackground addSubview:bouquetBtn];
    [_searchBackground addSubview:channelBtn];
    
    SEARCH_STATE = USER_SEARCH;
}

/*****************************************/
#pragma mark - Button action
/*****************************************/
- (void)pushedSearchButton:(UIButton*)button {
    float duration = 0.3f;
    
    if ([button.titleLabel.text isEqualToString:USER_BUTTON_TITLE]) {
        SEARCH_STATE = USER_SEARCH;
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:USER_BUTTON_FRAME];
            [_pushedBtnBorder setFrame:CGRectMake(USER_BUTTON_FRAME.origin.x+USER_BUTTON_FRAME.size.width/2-1,
                                                  USER_BUTTON_FRAME.origin.y+USER_BUTTON_FRAME.size.height, 2, 23)];
        } completion:^(BOOL finished) {
            [_table reloadData];
        }];
    } else if ([button.titleLabel.text isEqualToString:TITLE_BUTTON_TITLE]) {
        SEARCH_STATE = TITLE_SEARCH;
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:TITLE_BUTTON_FRAME];
            [_pushedBtnBorder setFrame:CGRectMake(TITLE_BUTTON_FRAME.origin.x+TITLE_BUTTON_FRAME.size.width/2-1,
                                                  TITLE_BUTTON_FRAME.origin.y+TITLE_BUTTON_FRAME.size.height, 2, 23)];
        } completion:^(BOOL finished) {
            [_table reloadData];
        }];
    } else if ([button.titleLabel.text isEqualToString:BOUQUET_BUTTON_TITLE]) {
        SEARCH_STATE = BOUQUET_SEARCH;
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:BOUQUET_BUTTON_FRAME];
            [_pushedBtnBorder setFrame:CGRectMake(BOUQUET_BUTTON_FRAME.origin.x+BOUQUET_BUTTON_FRAME.size.width/2-1,
                                                  BOUQUET_BUTTON_FRAME.origin.y+BOUQUET_BUTTON_FRAME.size.height, 2, 23)];
        } completion:^(BOOL finished) {
            [_table reloadData];
        }];
    } else if ([button.titleLabel.text isEqualToString:CHANNEL_BUTTON_TITLE]) {
        SEARCH_STATE = CHANNEL_SEARCH;
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:CHANNEL_BUTTON_FRAME];
            [_pushedBtnBorder setFrame:CGRectMake(CHANNEL_BUTTON_FRAME.origin.x+CHANNEL_BUTTON_FRAME.size.width/2-1,
                                                  CHANNEL_BUTTON_FRAME.origin.y+CHANNEL_BUTTON_FRAME.size.height, 2, 23)];
        } completion:^(BOOL finished) {
            [_table reloadData];
        }];
    }
}


/*****************************************/
#pragma mark - UITableViewDelegate
/*****************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_usrDataMary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (SEARCH_STATE == USER_SEARCH) {
        cell = (CCSearchCell*)[tableView dequeueReusableCellWithIdentifier:@"CCSearchCell" forIndexPath:indexPath];
        [(CCSearchCell*)cell setEntry:[_usrDataMary objectAtIndex:indexPath.row] withIndexPath:indexPath];
        
    } else if (SEARCH_STATE == TITLE_SEARCH) {
        cell = (CCTitleSearchCell*)[tableView dequeueReusableCellWithIdentifier:@"CCTitleSearchCell" forIndexPath:indexPath];
        [(CCTitleSearchCell*)cell setEntry:[_usrDataMary objectAtIndex:indexPath.row] withIndexPath:indexPath];
        
    } else if (SEARCH_STATE == BOUQUET_SEARCH) {
        cell = (CCSetSearchCell*)[tableView dequeueReusableCellWithIdentifier:@"CCSetSearchCell" forIndexPath:indexPath];
        [(CCSetSearchCell*)cell setEntry:[_usrDataMary objectAtIndex:indexPath.row] withIndexPath:indexPath];
        
    } else if (SEARCH_STATE == CHANNEL_SEARCH) {
        cell = (CCSetSearchCell*)[tableView dequeueReusableCellWithIdentifier:@"CCChannelSearchCell" forIndexPath:indexPath];
        [(CCChannelSearchCell*)cell setEntry:[_usrDataMary objectAtIndex:indexPath.row] withIndexPath:indexPath];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // CCSearchCell *cell = (CCSearchCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"UserPushSegue" sender:self];
}


@end
