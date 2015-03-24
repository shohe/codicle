//
//  CCPostFlowController.m
//  codicle
//
//  Created by SHOHE on 3/19/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostFlowController.h"
#import "CCPostPostViewController.h"
#import "CCCameraRollCell.h"

@interface CCPostFlowController ()<CCPostPostDelegate> {
    BOOL _isAnimated;
    NSMutableArray *_selectedAry;
    NSMutableArray *_selectImages;
}

@end

@implementation CCPostFlowController

static NSString * const reuseIdentifier = @"CCCameraRollCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init view
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.navigationController.view.backgroundColor = _CCColor();
    UIColor *alphaCollor = [_CCColor() colorWithAlphaComponent:.1f];
    
    self.navigationController.view.backgroundColor = alphaCollor;
    self.navigationController.navigationBar.backgroundColor = [_CCColor() colorWithAlphaComponent:.97f];
    self.collectionView.backgroundColor = alphaCollor;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _CCWINDOWSIZE().width, 20)];
    header.backgroundColor = [_CCColor() colorWithAlphaComponent:.97f];
    [self.navigationController.view addSubview:header];
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // left button
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(pushCancel)];
    cancelBtn.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    // right button
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(pushNext)];
    postBtn.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = postBtn;
    
    // back button.
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"Camera Roll";
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.backBarButtonItem = backBtn;
    
    self.navigationController.view.alpha = 0;
    [UIView animateWithDuration:.3f animations:^{
        self.navigationController.view.alpha = 1;
    }];
    
    _isAnimated = YES;
    _datasource = CCCORE.cameraRollData;
    _selectedAry = [NSMutableArray array];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_isAnimated) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:((int)[_datasource count]-1) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_isAnimated) {
        float delay = 0;
        for (int i=((int)[_datasource count]-1)-(int)[self.collectionView indexPathsForVisibleItems].count; i <= ((int)[_datasource count]-1); i++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexpath];
            
            CGRect originFrame = cell.frame;
            cell.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y+_CCWINDOWSIZE().height,
                                    originFrame.size.width, originFrame.size.height);
            
            [UIView animateWithDuration:.3f delay:delay*.01 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                cell.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y-5,
                                        originFrame.size.width, originFrame.size.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.2f animations:^{
                    cell.frame = originFrame;
                }];
            }];
            delay++;
        }
        _isAnimated = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushCancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [UIView animateWithDuration:.5f animations:^{
        self.navigationController.view.alpha = 0;
    }];
    [_delegate didPostCancel];
}

- (void)pushNext {
    _selectImages = [NSMutableArray array];
    for (NSIndexPath *index in _selectedAry) {
        CCCameraRollCell *cell = (CCCameraRollCell*)[self.collectionView cellForItemAtIndexPath:index];
        [CCCORE photoFromALAssets:cell.imagePath withCompletion:^(NSError *error, UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_selectImages addObject:image];
                if ([_selectImages count] == [_selectedAry count]) {
                    // alpha animation
                    [UIView animateWithDuration:.15 animations:^{
                        self.collectionView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:.1 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                            self.collectionView.alpha = 1;
                        } completion:nil];
                    }];
                    
                    // controller push
                    CCPostPostViewController *postPostViewController =
                    [self.storyboard instantiateViewControllerWithIdentifier:@"CCPostPostViewController"];
                    postPostViewController.delegate = self;
                    postPostViewController.selectImages = _selectImages;
                    [self.navigationController pushViewController:postPostViewController animated:YES];
                }
            });
        }];
    }
}

- (void)reloadNumber {
    for (NSIndexPath *index in _selectedAry) {
        CCCameraRollCell *cell = (CCCameraRollCell*)[self.collectionView cellForItemAtIndexPath:index];
        cell.number.text = [NSString stringWithFormat:@"%ld", [_selectedAry indexOfObject:index]+1];
    }
}

#pragma mark <CCPostPostDelegate>
- (void)didPostCancel {
    [self pushCancel];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_datasource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CCCameraRollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = _datasource[indexPath.row][@"IMAGE"];
    cell.imagePath = _datasource[indexPath.row][@"URL"];
    
    if ([_selectedAry containsObject:indexPath]) {
        cell.chkImage.backgroundColor = _CCBlueColor();
        cell.maskView.alpha = .5f;
        cell.indexPath = indexPath;
        cell.isSelected = YES;
        cell.number.text = [NSString stringWithFormat:@"%ld", [_selectedAry indexOfObject:indexPath]+1];
    } else {
        cell.chkImage.backgroundColor = [UIColor clearColor];
        cell.maskView.alpha = 0;
        cell.indexPath = nil;
        cell.isSelected = NO;
        cell.number.text = @"";
    }
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CCCameraRollCell *cell = (CCCameraRollCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.chkImage.backgroundColor = _CCBlueColor();
    cell.maskView.alpha = .5f;
    cell.indexPath = indexPath;
    cell.isSelected = YES;
    [_selectedAry addObject:indexPath];
    cell.number.text = [NSString stringWithFormat:@"%ld", [_selectedAry indexOfObject:indexPath]+1];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    CCCameraRollCell *cell = (CCCameraRollCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.chkImage.backgroundColor = [UIColor clearColor];
    cell.maskView.alpha = 0;
    cell.indexPath = nil;
    cell.isSelected = NO;
    [_selectedAry removeObject:indexPath];
    cell.number.text = @"";
    
    [self reloadNumber];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((_CCWINDOWSIZE().width-10*4)/3, (_CCWINDOWSIZE().width-10*4)/3);
}

@end
