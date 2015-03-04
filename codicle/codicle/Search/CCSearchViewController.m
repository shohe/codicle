//
//  CCSearchViewController.m
//  codicle
//
//  Created by SHOHE on 2/11/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCSearchViewController.h"
#import "CCSearchCell.h"

@interface CCSearchViewController () {
    UIView *_pushedSearchBtn;
    UIView *_searchBackground;
    
    CGRect USER_BUTTON_FRAME;
    CGRect TITLE_BUTTON_FRAME;
    CGRect BOUQUET_BUTTON_FRAME;
    CGRect CHANNEL_BUTTON_FRAME;
}

@end

@implementation CCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableview footer margin
    self.table.contentInset =
    (MARGIN_ON) ? UIEdgeInsetsMake(90, 0, 7.5, 0) : UIEdgeInsetsMake(0, 0, 49.0, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(90, 0, 0, 0);
    
    // datasource
    _usrDataMary = [NSMutableArray array];
    
    // search button init.
    [self initSearchButton];
    
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
    _searchBackground.backgroundColor = [[UIColor alloc] initWithRed:0.f/255.f green:155.f/255.f blue:173.f/255.f alpha:1];
    _searchBackground.alpha = 0.9f;
    
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
    _pushedSearchBtn.backgroundColor = [[UIColor alloc] initWithRed:15.f/255.f green:130.f/255.f blue:150.f/255.f alpha:1.f];
    _pushedSearchBtn.layer.cornerRadius = _pushedSearchBtn.frame.size.height/2;
    _pushedSearchBtn.clipsToBounds = YES;
    
    [userBtn setTitle:USER_BUTTON_TITLE forState:UIControlStateNormal];
    [titleBtn setTitle:TITLE_BUTTON_TITLE forState:UIControlStateNormal];
    [bouquetBtn setTitle:BOUQUET_BUTTON_TITLE forState:UIControlStateNormal];
    [channelBtn setTitle:CHANNEL_BUTTON_TITLE forState:UIControlStateNormal];
    
    userBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:9.5];
    titleBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:9.5];
    bouquetBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:9.5];
    channelBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:9.5];
    
    [userBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    [titleBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    [bouquetBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    [channelBtn addTarget:self action:@selector(pushedSearchButton:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:_searchBackground];
    [_searchBackground addSubview:_pushedSearchBtn];
    [_searchBackground addSubview:userBtn];
    [_searchBackground addSubview:titleBtn];
    [_searchBackground addSubview:bouquetBtn];
    [_searchBackground addSubview:channelBtn];
}

/*****************************************/
#pragma mark - Button action
/*****************************************/
- (void)pushedSearchButton:(UIButton*)button {
    float duration = 0.3f;
    
    if ([button.titleLabel.text isEqualToString:USER_BUTTON_TITLE]) {
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:USER_BUTTON_FRAME];
        }];
    } else if ([button.titleLabel.text isEqualToString:TITLE_BUTTON_TITLE]) {
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:TITLE_BUTTON_FRAME];
        }];
    } else if ([button.titleLabel.text isEqualToString:BOUQUET_BUTTON_TITLE]) {
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:BOUQUET_BUTTON_FRAME];
        }];
    } else if ([button.titleLabel.text isEqualToString:CHANNEL_BUTTON_TITLE]) {
        [UIView animateWithDuration:duration animations:^{
            [_pushedSearchBtn setFrame:CHANNEL_BUTTON_FRAME];
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
    
    NSString *cellIdentifier = @"CCSearchCell";
    CCSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CCSearchCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setEntry:[_usrDataMary objectAtIndex:indexPath.row] withIndexPath:indexPath];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // CCSearchCell *cell = (CCSearchCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"UserPushSegue" sender:self];
}


@end
