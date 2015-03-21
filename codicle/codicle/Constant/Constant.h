//
//  Constant.h
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG == 1
#define CCLog(fmt, ...) NSLog((@"%s L%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define CCLog(...)
#endif

#define MARGIN_ON 1


/*****************************************/
// search button
/*****************************************/
extern NSString * const USER_BUTTON_TITLE;
extern NSString * const TITLE_BUTTON_TITLE;
extern NSString * const BOUQUET_BUTTON_TITLE;
extern NSString * const CHANNEL_BUTTON_TITLE;



/*****************************************/
// function
/*****************************************/
CGSize  _CCWINDOWSIZE();
UIColor* _CCColor();
UIColor* _CCBtnColor();
UIColor* _CCBlueColor();