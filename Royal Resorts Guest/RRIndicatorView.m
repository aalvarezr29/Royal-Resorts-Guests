//
//  RRIndicatorView.m
//  iRest
//
//  Created by Blas Ramos on 9/13/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import "RRIndicatorView.h"
#import "RRTableViewController.h"

@implementation RRIndicatorView
{
    @private UIAlertView *_waitAlert;
    @private NSString *_title;
}

/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
*/


-(id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        _title = [[NSString alloc]initWithString:title];
    }
    return self;
}

-(void)startIndicator
{
    [self invokeWaitAlertPopupWithTitle:_title];
}

-(void)stopIndicator
{
    [self dismissWaitAlertPopup];
}

-(void)invokeWaitAlertPopupWithTitle : (NSString *) title
{
    _waitAlert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [_waitAlert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //indicator.center = CGPointMake(_waitAlert.bounds.size.width / 2,
    //                               _waitAlert.bounds.size.height - 45);
   
    indicator.center = CGPointMake(142,68);
    
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhoneSB" bundle:nil];
    RRTableViewController *table = [storyboard instantiateViewControllerWithIdentifier:@"TableVC"];
    
    indicator.center = CGPointMake(table.view.frame.size.width /2,
                                   table.view.frame.size.height - 45);
    */

    [indicator startAnimating];
    [_waitAlert addSubview:indicator];
    
}

-(void)dismissWaitAlertPopup
{
    [_waitAlert dismissWithClickedButtonIndex:0 animated:YES];
    _waitAlert = nil;
}

-(void)setTitle:(NSString *)title
{
    if (self)
    {
        _title = title;
    }
}

@end
