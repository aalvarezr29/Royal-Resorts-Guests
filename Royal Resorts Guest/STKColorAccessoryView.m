//
//  STKColorAccessoryView.m
//  ColorAccessoryView
//
//  Created by Sean Kladek on 5/9/14.
//  Copyright (c) 2014 Sean Kladek. All rights reserved.
//

#import "STKColorAccessoryView.h"

@interface STKColorAccessoryView ()

@property (strong, nonatomic) UIColor *color;

@end

@implementation STKColorAccessoryView

+ (STKColorAccessoryView *)accessoryViewWithColor:(UIColor *)color
{
    STKColorAccessoryView *view = [[STKColorAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 15.f) color:color];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat edgeOffset = 2.f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, edgeOffset, edgeOffset);
    CGContextAddLineToPoint(context, rect.size.width - edgeOffset, rect.size.height / 2);
    CGContextAddLineToPoint(context, edgeOffset, rect.size.height - edgeOffset);
    
    CGContextSetLineWidth(context, 2.5f);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextStrokePath(context);
}


@end
