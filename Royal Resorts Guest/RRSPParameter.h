//
//  RRSPParameter.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum storedProcedureParameterType
{
    INT,    
    VARCHAR,
    CHAR,
    BIT,
    MONEY,
    XML,
    DATE,
    DATETIME,
    SMALLINT,
    FLOAT
} ParameterType;

typedef enum storedProcedureParameterDirection
{
    IN,
    OUT
} ParameterDirection;


@interface RRSPParameter : NSObject

@property (nonatomic, strong) NSString *parameterName;
@property ParameterDirection parameterDirection;
@property ParameterType parameterType;
@property (nonatomic, strong) NSString *parameterPrecision;
@property (nonatomic, strong) NSString *parameterValue;

-(NSString*) getParameterInJSONFormat;

-(RRSPParameter*) initWithName:(NSString*)name Direction:(ParameterDirection)direction Type:(ParameterType)type Value:(NSString*)value;

-(RRSPParameter*) initWithName:(NSString*)name Direction:(ParameterDirection)direction Type:(ParameterType)type Value:(NSString*)value Precision:(NSString*)precision;

@end
