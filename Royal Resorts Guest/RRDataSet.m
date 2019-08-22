//
//  RRDataSet.m
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import "RRDataSet.h"
#import "SBJson.h"
@implementation RRDataSet

@synthesize tables = _tables;

//Agrega un nuevo RRDataTable al dataset
-(void) addNewTable:(RRDataTable *)table  
{
    if (_tables == nil) {
        _tables = [[NSMutableArray alloc]init];
    }
    
    [_tables addObject:table];
}

//Devuelve el numero de tablas que pertenecen al dataset
-(int) getTotalTables{
    return [_tables count];    
}

-(RRDataTable*) getTableAtIndex:(NSUInteger *)index
{
    RRDataTable *table = [_tables objectAtIndex:*index];
    return table;  
}

-(RRDataTable*) getTableByName:(NSString *)tableName
{
    for (RRDataTable * table in _tables){
        if ([table.tableName isEqualToString:tableName]) {
            return table;
        }
    }
    
    return nil;
}

-(RRDataSet*) initWithJSONString:(NSString*) strJSONArray
{
    NSArray * JSONTokens = [strJSONArray componentsSeparatedByString:@"&SEP&"];
    
    RRDataSet *dtsDatos = [[RRDataSet alloc] init];
    
    for (NSString *JSONToken in JSONTokens) {        
        [dtsDatos addNewTable: [self getDataTable:JSONToken]];
    }
    
    return dtsDatos;
}


-(RRDataTable*) getDataTable:(NSString*) strJSONArray{
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
//    NSArray *arr = [jsonParser objectWithString:strJSONArray error:&error];
    
    NSData *data = [strJSONArray dataUsingEncoding:NSUTF8StringEncoding];    
    
    NSArray *arr = [jsonParser objectWithData:data];
   
    
   
    
    NSEnumerator *enumerator;
    NSString *key;
    RRDataRow *row;
    RRDataColumn *column;
    RRDataTable *dtDatos = [[RRDataTable alloc] init];
        
    jsonParser = nil;    
    error = nil;
    
    //Recorremos cada posicion del arreglo para obtener todos los campos con sus valores que correspondan.
    for (NSDictionary *catalog in arr)
    {
        enumerator = [catalog keyEnumerator];
        
        row = [[RRDataRow alloc] init];               
        
        while ((key = [enumerator nextObject])) 
        {
            
            column = [[RRDataColumn alloc] init];
            [column setColumnName:key];
            
            if ( [catalog objectForKey:key] == (NSString *)[NSNull null] ){
                [column setContent:@""];
            }else{
                [column setContent:[catalog objectForKey:key]];
            }
          
            [row addColumn:column];
            
           
            column = nil;
            
        }
        
        [dtDatos addNewRow:row];  
        
       
        row = nil;
    }
    
    return dtDatos;
}
@end
