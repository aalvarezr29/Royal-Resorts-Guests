//
//  RRStoredProcedure.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRSPParameter.h"
#import "RRDataSet.h"


@interface RRStoredProcedure : NSObject

typedef void (^RRCurrencyResponseBlock)(double rate);

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *schema;
@property (nonatomic, strong) NSString *database;
@property (nonatomic, strong) NSMutableArray *parameters;
@property (nonatomic, strong) NSString *webserviceURL;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *userNameMobile;
@property (nonatomic, strong) NSString *passwordMobile;

-(RRStoredProcedure*) initWithName:(NSString*)name Schema:(NSString*)schema DataBase:(NSString *) database WebServiceURL:(NSString*) webserviceURL userNameMobile:(NSString *) userNameMobile passwordMobile:(NSString*) passwordMobile;

-(RRStoredProcedure*) initWithName:(NSString*)name DataBase:(NSString *) database WebServiceURL:(NSString*) webserviceURL;

-(RRStoredProcedure*) initWithUserName:(NSString*) user Password:(NSString*) password SPName:(NSString *)spName Schema:(NSString *)schema DataBase:(NSString *)database WebServiceURL:(NSString *)webserviceURL;

-(void) addParameterWithName:(NSString*)name Direction:(ParameterDirection)direction Type:(ParameterType) type Value:(NSString*) value;

-(void) addParameterWithName:(NSString*)name Direction:(ParameterDirection)direction Type:(ParameterType) type Value:(NSString*) value Precision:(NSString *) precision;

/*
Ejecuta el procedimiento almacenado mediante el web service generico y devuelve un dataset con el resultado de la ejecucion y en caso de que haya algun error retorna la descripcion en result.
 */
-(RRDataSet*) execWithResult:(NSString**) result;

-(RRDataSet*) execMobileWithResult:(NSString**) result;


@end
