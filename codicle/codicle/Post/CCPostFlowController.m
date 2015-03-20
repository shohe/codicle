//
//  CCPostFlowController.m
//  codicle
//
//  Created by SHOHE on 3/19/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostFlowController.h"
#import "CCPostPostViewController.h"

@interface CCPostFlowController () {
    BOOL _isAnimated;
}

@end

@implementation CCPostFlowController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init view
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
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_isAnimated) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:99 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_isAnimated) {
        float delay = 0;
        for (int i=99-(int)[self.collectionView indexPathsForVisibleItems].count; i <= 99; i++) {
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
    
    CCPostPostViewController *postPostViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"CCPostPostViewController"];
    [self.navigationController pushViewController:postPostViewController animated:YES];
    
    
    [UIView animateWithDuration:.5 animations:^{
        self.collectionView.alpha = 0;
    } completion:^(BOOL finished) {
        self.collectionView.alpha = 1;
    }];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    return CGSizeMake((_CCWINDOWSIZE().width-10*4)/3, (_CCWINDOWSIZE().width-10*4)/3);
}

@end
