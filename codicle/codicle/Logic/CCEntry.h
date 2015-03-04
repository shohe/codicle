//
//  CCEntry.h
//  codicle
//
//  Created by SHOHE on 2/8/15.
//  Copyright (c) 2015 OhtaniShohe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCEntry : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *articleUrl;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, strong) NSString *usrName;
@property (nonatomic, strong) NSString *usrImgUrl;
@property (nonatomic, strong) NSNumber *view;
@property (nonatomic, strong) NSNumber *like;
@property (nonatomic, strong) NSNumber *retweet;
@property (nonatomic, strong) NSNumber *reaction;

@end
