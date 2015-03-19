//
//  CCPostFlowController.m
//  codicle
//
//  Created by SHOHE on 3/19/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCPostFlowController.h"

@interface CCPostFlowController ()

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
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(pushCancel)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    self.navigationController.view.alpha = 0;
    [UIView animateWithDuration:.3f animations:^{
        self.navigationController.view.alpha = 1;
    }];

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

- (void)collectionCellAnimation {
    NSArray *visiblePaths = [self.collectionView visibleCells];
    CCLog(@"%@", visiblePaths);
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
