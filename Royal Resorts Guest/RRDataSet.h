//
//  RRDataSet.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRDataTable.h"

@interface RRDataSet : NSObject

@property (nonatomic, strong) NSMutableArray *tables;


-(void) addNewTable:(RRDataTable*) table;
-(int) getTotalTables;
-(RRDataTable *) getTableAtIndex:(NSUInteger*) index;
-(RRDataTable *) getTableByName:(NSString *) tableName;
-(RRDataSet *) initWithJSONString:(NSString *) strJSONArray;

@end
