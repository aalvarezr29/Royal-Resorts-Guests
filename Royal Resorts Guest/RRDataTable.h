//
//  RRDataTable.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/8/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRDataRow.h"

@interface RRDataTable : NSObject

@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) NSString *tableName;

-(void) addNewRow:(RRDataRow*) row;

-(int) getTotalRows;

-(RRDataRow *) RowAtIndex:(NSUInteger*) index;

@end
