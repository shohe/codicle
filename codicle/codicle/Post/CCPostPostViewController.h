//
//  CCPostPostViewController.h
//  codicle
//
//  Created by SHOHE on 3/20/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCBaseViewController.h"

@protocol CCPostPostDelegate <NSObject>
- (void)didPostCancel;
@end

@interface CCPostPostViewController : CCBaseViewController

@property (nonatomic, strong) id<CCPostPostDelegate>delegate;
@property (nonatomic, strong) NSArray *selectImages;

@end
