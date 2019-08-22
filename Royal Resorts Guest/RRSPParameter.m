//
//  RRSPParameter.m
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import "RRSPParameter.h"

@implementation RRSPParameter

@synthesize parameterName = _parameterName;
@synthesize parameterDirection = _parameterDirection;
@synthesize parameterType = _parameterType;
@synthesize parameterPrecision = _parameterPrecision;
@synthesize parameterValue = _parameterValue;


-(RRSPParameter*) initWithName:(NSString *)name Direction:(ParameterDirection)direction Type:(ParameterType)type Value:(NSString *)value
{    
    return [self initWithName:name Direction:direction Type:type Value:value Precision:nil];
}

-(RRSPParameter*) initWithName:(NSString *)name Direction:(ParameterDirection)direction Type:(ParameterType)type Value:(NSString *)value Precision:(NSString *)precision
{
    _parameterName = name;
    _parameterDirection = direction;
    _parameterType = type;
    _parameterValue = value;
    _parameterPrecision = precision;
    
    return self;
}

-(NSString*) getParameterInJSONFormat{

    NSString * paramType;
    NSString * paramDirection;
                
    switch (_parameterType) {
        case 0:
            paramType = @"int";
            break;
        case 1:
            paramType = @"varchar";
            break;
        case 2:
            paramType = @"char";
            break;
        case 3:
            paramType = @"bit";
            break;
        case 4:
            paramType = @"money";
            break;
        case 5:
            paramType = @"xml";
            break;
        case 6:
            paramType = @"date";
            break;
        case 7:
            paramType = @"datetime";
            break;
        case 8:
            paramType = @"smallint";
            break;
        default:
            paramType = @"varchar";
            break;
    }
    
    if (_parameterDirection == 0)
        paramDirection = @"IN";
    else
        paramDirection = @"OUT";
            
    NSString *parameter = [[NSString alloc] initWithFormat:@"{\"Name\":\"%@\",\"Direction\":\"%@\",\"Type\":\"%@\",\"Precision\":\"%@\",\"Value\":\"%@\"}", _parameterName, paramDirection, paramType, _parameterPrecision, _parameterValue];
    
    
    paramType = nil;
    
    paramDirection = nil;
    
    return parameter;
}


@end
