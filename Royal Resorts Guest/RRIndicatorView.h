//
//  RRIndicatorView.h
//  iRest
//
//  Created by Blas Ramos on 9/13/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRIndicatorView : UIView

-(id)initWithTitle:(NSString *)title;
-(void)startIndicator;
-(void)stopIndicator;
-(void)setTitle:(NSString *)title;

@end
