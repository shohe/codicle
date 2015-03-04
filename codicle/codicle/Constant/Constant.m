//
//  Constant.m
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import "Constant.h"


/*****************************************/
// search button
/*****************************************/
NSString * const USER_BUTTON_TITLE = @"ユーザー";
NSString * const TITLE_BUTTON_TITLE = @"タイトル";
NSString * const BOUQUET_BUTTON_TITLE = @"ブーケ";
NSString * const CHANNEL_BUTTON_TITLE = @"チャンネル";


/*****************************************/
// function
/*****************************************/
CGSize _CCWINDOWSIZE(){
    static CGSize windowSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        windowSize = [[UIScreen mainScreen] bounds].size;
    });
    return windowSize;
}