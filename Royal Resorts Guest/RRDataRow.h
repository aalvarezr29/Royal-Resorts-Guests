//
//  RRDataRow.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/7/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRDataColumn.h"


@interface RRDataRow : NSObject

@property (nonatomic,strong) NSMutableArray *columns;

-(void)addColumn:(RRDataColumn*)column;

-(RRDataColumn*)getColumnByName:(NSString*)name;

-(RRDataColumn*)getColumnAtIndex:(NSUInteger) index;
@end
