//
//  CCHomeViewController.m
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCHomeViewController.h"
#import "CCTimeLineCell.h"
#import "FLAnimatedImage.h"

@interface CCHomeViewController () {
//    NSMutableArray *testMary;
//    NSMutableArray *testMary2;
    UIColor *marginCellColor;
}

@end

@implementation CCHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // datasource
    _dataMary = [NSMutableArray array];
    
    // tableview footer margin
    self.table.contentInset =
        (MARGIN_ON) ? UIEdgeInsetsMake(-10, 0, 7.5, 0) : UIEdgeInsetsMake(0, 0, 49.0, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
