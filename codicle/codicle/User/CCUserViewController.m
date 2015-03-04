//
//  CCUserViewController.m
//  codicle
//
//  Created by SHOHE on 3/4/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCUserViewController.h"


#define USER_INFO_FRAME 350
@interface CCUserViewController () {
    UIImageView *_infoHeader;
    CGRect _infoHeaderFrame;
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
    
    cell.textLabel.text = @"text";
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
