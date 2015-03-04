//
//  CCCore.h
//  codicle
//
//  Created by SHOHE on 2/18/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAnimatedImage.h"

typedef void (^CCLoadDataCompletion)(NSError *error , NSMutableArray *mary);
typedef void (^CCLoadGifCompletion)(FLAnimatedImage * image);
typedef void (^CCLoadImgCompletion)(UIImage * image);

#define CCCORE [CCCore core]

@interface CCCore : NSObject
@property (nonatomic,strong) NSCache *urlImageCache;

+ (CCCore*)core;
/*****************************************/
#pragma mark - Loading
/*****************************************/
- (void)loadTimeLineWithCompletion:(CCLoadDataCompletion)completion;
- (void)gifImageAtURL:(NSString*)url completion:(CCLoadGifCompletion)completion;
- (void)imageAtURL:(NSString*)url completion:(CCLoadImgCompletion)completion;

/*****************************************/
#pragma mark - test data
/*****************************************/
- (void)loadTestDataWithCompletion:(CCLoadDataCompletion)completion;

@end
