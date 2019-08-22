//
//  RRDataColumn.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/7/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRDataColumn : NSObject

//Nombre de la columna que mapea.
@property (nonatomic,strong) NSString *columnName;

//Tipo de dato de la columna
@property (nonatomic, strong) NSString *dataType;


//Contenido de la celda.
@property (nonatomic, strong) id content;


//Indicara si tiene valor nulo la celda
@property (nonatomic, assign) BOOL isDBNull;



@end
