//
//  RRDataRow.m
//  SPA
//
//  Created by Ernesto Fuentes on 6/7/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import "RRDataRow.h"
#import "RRDataColumn.h"

@implementation RRDataRow

@synthesize columns = _columns;

-(void)addColumn:(RRDataColumn *)column
{     
    if (_columns == nil) {
        _columns = [[NSMutableArray alloc] init];
    }
    
    
    //Verificamos que no exista la colimna que queremos insertar
    for (RRDataColumn* col in _columns) {
        
        //Si la columna ya existe no podemos agregarla 
        if ([col.columnName isEqualToString:column.columnName]) 
        {
            @throw ([NSException exceptionWithName:@"InvalidOperationException" reason:@"No es posible agregar 2 columnas con el mismo nombre" userInfo:nil]);                           
        }
    }    
    
    //Podemos agregar la columna porque no existe mas.
    [_columns addObject:column];
}

-(RRDataColumn*)getColumnByName:(NSString *)name
{
    
    for (RRDataColumn * col in _columns){
        if ([col.columnName isEqualToString:name]) {
            return col;
        }
    }
   
    return nil;
}

-(RRDataColumn*) getColumnAtIndex:(NSUInteger)index
{
    RRDataColumn *col = [_columns objectAtIndex: index];
    
    return col;
    
}

@end
