//
//  CCCore.h
//  codicle
//
//  Created by SHOHE on 2/18/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAnimatedImage.h"

typedef void (^CCLoadCameraRollCompletion)(NSError *error, NSArray *mary);
typedef void (^CCLoadDataCompletion)(NSError *error , NSMutableArray *mary);
typedef void (^CCLoadGifCompletion)(FLAnimatedImage * image);
typedef void (^CCLoadImgCompletion)(UIImage * image);

#define CCCORE [CCCore core]

@interface CCCore : NSObject
@property (nonatomic,strong) NSCache *urlImageCache;
@property (readwrite) NSInteger *lastTabIndex;
@property (nonatomic,strong) NSArray *cameraRollData;

+ (CCCore*)core;
/*****************************************/
#pragma mark - Loading
/*****************************************/
- (void)loadTimeLineWithCompletion:(CCLoadDataCompletion)completion;
- (void)gifImageAtURL:(NSString*)url completion:(CCLoadGifCompletion)completion;
- (void)imageAtURL:(NSString*)url completion:(CCLoadImgCompletion)completion;
- (void)loadCameraRollListWithCompletion:(CCLoadCameraRollCompletion)completion;

/*****************************************/
#pragma mark - test data
/*****************************************/
- (void)loadTestDataWithCompletion:(CCLoadDataCompletion)completion;

@end
