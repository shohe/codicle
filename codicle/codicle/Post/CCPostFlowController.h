//
//  CCPostFlowController.h
//  codicle
//
//  Created by SHOHE on 3/19/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCPostFlowDelegate <NSObject>
- (void)didPostCancel;
@end

@interface CCPostFlowController : UICollectionViewController

@property (nonatomic, strong) id<CCPostFlowDelegate>delegate;
@property (nonatomic, strong) NSArray *datasource;

@end
