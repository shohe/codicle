//
//  YLGIFImage.h
//  YLGIFImage
//
//  Created by Yong Li on 14-3-2.
//  Copyright (c) 2014年 Yong Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLGIFImage : UIImage

///-----------------------
/// @name Image Attributes
///-----------------------

/**
 A C array containing the frame durations.
 
 The number of frames is defined by the count of the `images` array property.
 */
@property (nonatomic, readwrite) NSTimeInterval *frameDurations;

/**
 Total duration of the animated image.
 */
@property (nonatomic, readwrite) NSTimeInterval totalDuration;

/**
 Number of loops the image can do before it stops
 */
@property (nonatomic, readwrite) NSUInteger     loopCount;
@property (nonatomic, readwrite) NSMutableArray *images;

- (UIImage*)getFrameWithIndex:(NSUInteger)idx;
- (void)animationInSliderValue:(float)fromValue to:(float)toValue withDuration:(NSTimeInterval)inDuration;

@end
