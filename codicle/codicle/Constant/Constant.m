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
NSString * const BOUQUET_BUTTON_TITLE = @"セット";
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

UIColor* _CCColor() {
    return [UIColor colorWithRed:227.0f/255.0f green:230.0f/255.0f blue:237.0f/255.0f alpha:1];
}