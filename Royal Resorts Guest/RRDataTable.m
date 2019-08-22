//
//  RRDataTable.m
//  SPA
//
//  Created by Ernesto Fuentes on 6/8/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import "RRDataTable.h"

@implementation RRDataTable

@synthesize rows = _rows;
@synthesize tableName = _tableName;


//Agrega un nuevo RRDataRow a la tabla
-(void) addNewRow:(RRDataRow *)row  
{
    if (_rows == nil) {
        _rows = [[NSMutableArray alloc]init];
    }
    
    [_rows addObject:row];
}


//Devuelve el numero de registros que contiene la tabla
-(int) getTotalRows
{
   return [_rows count];
}

//Retorna la fila en la posicion que se reciba por parametro
-(RRDataRow *) RowAtIndex:(NSUInteger*)index
{
    RRDataRow *row = [_rows objectAtIndex:*index];
    return row;   
}


@end
