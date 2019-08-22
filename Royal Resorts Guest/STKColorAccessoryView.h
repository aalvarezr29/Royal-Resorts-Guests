//
//  STKColorAccessoryView.h
//  ColorAccessoryView
//
//  Created by Sean Kladek on 5/9/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STKColorAccessoryView : UIView

/**
 Creates and returns a disclosure accessory view in the specified color
 @param color
 The color of the resulting accessory
 @return A disclosure accessory view in the specified color
 */
+ (STKColorAccessoryView *)accessoryViewWithColor:(UIColor *)color;

@end
