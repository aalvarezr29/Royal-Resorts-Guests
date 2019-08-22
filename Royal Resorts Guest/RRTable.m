//
//  RRTable.m
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/28/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import "RRTable.h"

@implementation RRTable

@synthesize lblTitle = _lblTitle;
@synthesize imgPicture = _imgPicture;
@synthesize strTableNo = _strTableNo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
