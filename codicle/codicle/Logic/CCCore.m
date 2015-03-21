//
//  CCCore.m
//  codicle
//
//  Created by SHOHE on 2/18/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "CCCore.h"
#import "CCEntry.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation CCCore

+ (CCCore*)core {
    static CCCore* core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[CCCore alloc] init];
    });
    return core;
}


/*****************************************/
#pragma mark - load data
/*****************************************/
- (void)loadTimeLineWithCompletion:(CCLoadDataCompletion)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSString *url  = @"";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        if (!data)
        {
            CCLog(@"Network error");
            return;
        }
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (jsonDic != nil && [jsonDic objectForKey:@""])
        {
            NSMutableArray *mary = [NSMutableArray array];
            for (NSDictionary *json in [jsonDic objectForKey:@""]) {
                CCEntry *ccEntry = [[CCEntry alloc] init];
                ccEntry.title           = json[@""];
                ccEntry.articleUrl      = json[@""];
                ccEntry.thumbnailUrl    = json[@""];
                ccEntry.usrName         = json[@""];
                ccEntry.usrImgUrl       = json[@""];
                ccEntry.view            = json[@""];
                ccEntry.like            = json[@""];
                ccEntry.retweet         = json[@""];
                ccEntry.reaction        = json[@""];
                [mary addObject:ccEntry];
            }
            completion(error, mary);
        }
        else
        {
            CCLog(@"Codicle API Error :%@", jsonDic[@"resultMessage"]);
        }
    });
}

//* FLAnimatedImage
- (void)gifImageAtURL:(NSString*)url completion:(CCLoadGifCompletion)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _urlImageCache = [[NSCache alloc]init];
            [_urlImageCache setCountLimit:50];
        });
        
        if ([_urlImageCache objectForKey:url]) {
            completion([_urlImageCache objectForKey:url]);
        } else {
            NSString *imageURL = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            imageURL = [imageURL stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
            completion(image);
            
            if (image) {
                [_urlImageCache setObject:image forKey:url];
            }
        }
    });
}

//* UIImage
- (void)imageAtURL:(NSString*)url completion:(CCLoadImgCompletion)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _urlImageCache = [[NSCache alloc]init];
            [_urlImageCache setCountLimit:50];
        });
        
        if ([_urlImageCache objectForKey:url]) {
            completion([_urlImageCache objectForKey:url]);
        } else {
            NSString *imageURL = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            imageURL = [imageURL stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            UIImage *image = [[UIImage alloc] initWithData:data];
            completion(image);
            
            if (image) {
                [_urlImageCache setObject:image forKey:url];
            }
        }
    });
}


#pragma mark - load CameraRoll
- (void)loadCameraRollListWithCompletion:(CCLoadCameraRollCompletion)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        NSMutableArray *mary = [NSMutableArray array];
        [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            if (group) {
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        ALAssetRepresentation *rep = [result defaultRepresentation];
                        NSDate *date = [result valueForProperty:ALAssetPropertyDate];
                        NSURL *url = [rep url];
                        UIImage *image = [UIImage imageWithCGImage:result.thumbnail scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
                        NSString *timeString = [NSString stringWithFormat:@"%@", [result valueForProperty:ALAssetPropertyDuration]];
                        NSDictionary *assetData = [[NSDictionary alloc] initWithObjectsAndKeys:image, @"IMAGE",url, @"URL",date, @"DATE",timeString, @"TIME", nil];
                        [mary insertObject:assetData atIndex:0];
                        completion(error, mary);
                    }
                }];
            }
            
        } failureBlock:^(NSError *error) {
            completion(error, mary);
        }];
    });
}

/*****************************************/
#pragma mark - test data
/*****************************************/
- (void)loadTestDataWithCompletion:(CCLoadDataCompletion)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSArray * thumbUrlAry = @[@"http://static.tumblr.com/78708c8c0ab6a659f4323a82d54d4dc5/cjtdloz/V9Fmyvp0z/tumblr_static_red_redder_reddest.jpg",@"https://secure.static.tumblr.com/07f3206c3ab9fc46fc32d353e6b76d07/dvivlbo/0LQn3bn53/tumblr_static_tumblr-8.jpg",@"http://i36.photobucket.com/albums/e40/thedebrief/Gif3_zps2htwwlpq.gif"];
        NSArray * usrImgUrlAry = @[@"http://images4.fanpop.com/image/photos/20600000/Cute-Wallpaper-teddybear64-20682571-1280-1024.jpg",@"http://i.kinja-img.com/gawker-media/image/upload/s--5E4o28X---/v4cgzvbywym7zwocbrpb.jpg",@"http://www.yesvegetarian.com/wp-content/uploads/2014/11/Cute-Dogs1.jpg"];
        NSMutableArray *mary = [NSMutableArray array];
        for (int i=0; i<3; i++) {
            CCEntry *ccEntry = [[CCEntry alloc] init];
            ccEntry.title           = [NSString stringWithFormat:@"test title %i", i+1];
            ccEntry.articleUrl      = @"https://www.tumblr.com/";
            ccEntry.thumbnailUrl    = [thumbUrlAry objectAtIndex:i];
            ccEntry.usrName         = [NSString stringWithFormat:@"Mr.Test%i", i+1];
            ccEntry.usrImgUrl       = [usrImgUrlAry objectAtIndex:i];
            ccEntry.view            = [NSNumber numberWithInt:(i+1)*30];
            ccEntry.like            = [NSNumber numberWithInt:(i+1)*3];
            ccEntry.retweet         = [NSNumber numberWithInt:(i+1)*4];
            ccEntry.reaction        = [NSNumber numberWithInt:(i+1)*5];
            [mary addObject:ccEntry];
        }
        completion(error, mary);
    });
}

@end
