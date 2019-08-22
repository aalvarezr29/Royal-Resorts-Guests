//
//  RRStoredProcedure.m
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import "RRStoredProcedure.h"
#import "RRWebServiceParser.h"


@implementation RRStoredProcedure

@synthesize name = _name;
@synthesize schema = _schema;
@synthesize database = _database;
@synthesize parameters = _parameters;
@synthesize webserviceURL = _webserviceURL;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize userNameMobile = _userNameMobile;
@synthesize passwordMobile = _passwordMobile;

//Crea una nueva instancia de la clase RRStoredProcedure
-(RRStoredProcedure*) initWithName:(NSString *)name Schema:(NSString *)schema DataBase:(NSString *)database WebServiceURL:(NSString *)webserviceURL userNameMobile:(NSString *) userNameMobile passwordMobile:(NSString*) passwordMobile
{
    _name = name;
    _schema = schema;
    _database = database;
    _webserviceURL = webserviceURL;
    _userNameMobile = userNameMobile;
    _passwordMobile = passwordMobile;
    return self;
}

//Crea una nueva instancia de la clase RRStoredProcedure
-(RRStoredProcedure*) initWithName:(NSString *)name DataBase:(NSString *)database WebServiceURL:(NSString *)webserviceURL
{
    _name = name;
    _database = database;
    _webserviceURL = webserviceURL;
    
    return self;
}

//Crea una nueva instancia de la clase RRStoredProcedure con el usuario y password que se va a utilizar para ejectuar el metodo
-(RRStoredProcedure*) initWithUserName:(NSString*) user Password:(NSString*) password SPName:(NSString *)spName Schema:(NSString *)schema DataBase:(NSString *)database WebServiceURL:(NSString *)webserviceURL userNameMobile:(NSString *) userNameMobile passwordMobile:(NSString*) passwordMobile
{
    _userName = user;
    _password = password;
    
    return [self initWithName:spName Schema:schema DataBase:database WebServiceURL:webserviceURL userNameMobile: userNameMobile passwordMobile: passwordMobile];
    
}

-(RRStoredProcedure*) initWithUserName:(NSString*) user Password:(NSString*) password SPName:(NSString *)spName Schema:(NSString *)schema DataBase:(NSString *)database WebServiceURL:(NSString *)webserviceURL
{
    _userName = user;
    _password = password;
    
    return [self initWithName:spName Schema:schema DataBase:database WebServiceURL:webserviceURL userNameMobile: user passwordMobile: password];
    
}

//Agrega un nuevo parametro al procedimiento almacenado para su ejecucion
-(void) addParameterWithName:(NSString*)name Direction:(ParameterDirection)direction Type:(ParameterType) type Value:(NSString*) value
{    
    [self addParameterWithName:name Direction:direction Type:type Value:value Precision:nil];
}


//Agrega un nuevo parametro al procedimiento almacenado para su ejecucion 
-(void) addParameterWithName:(NSString*)name Direction:(ParameterDirection)direction Type:(ParameterType) type Value:(NSString*) value Precision:(NSString *) precision
{
    RRSPParameter * parameter; 
    
    if (_parameters == nil)
    {
        _parameters = [[NSMutableArray alloc] init];
    }
    else {       
        
        for (RRSPParameter *p in _parameters) {
            if ([p.parameterName isEqualToString:name] ) {
                @throw ([NSException exceptionWithName:@"InvalidOperationException" reason:@"No es posible agregar 2 parametros con el mismo nombre" userInfo:nil]);
            }        
        }
        
    }
    
    parameter = [[RRSPParameter alloc] initWithName:name Direction:direction Type:type Value:value Precision:precision]; 
    
    [_parameters addObject:parameter];
}


//Devuelve la lista de parametros del procedimiento almacenado en formato JSON
-(NSString*)getParametersInJSONFormat
{
    NSMutableString *JSONString;
    BOOL isFirstElement = YES ;
    
    if (_parameters != nil) {
        
        JSONString = [[NSMutableString alloc] initWithString:@"["];
        
        for (RRSPParameter *p in _parameters){
            
            if (isFirstElement == YES) {
                [JSONString appendString:[NSString stringWithFormat:@"%@",[p getParameterInJSONFormat]]];
                isFirstElement = NO;
            }
            else {
                [JSONString appendString:[NSString stringWithFormat:@",%@",[p getParameterInJSONFormat]]];
            }           
            
        }
        
        [JSONString appendString:@"]"];
    }
    
    return JSONString;    
}


// Ejecutamos el web service generico
/*
 * aitzac, 16-Oct-2014
 * Metodo para el webservice "http://wdev.royalresorts.local/RestaurantService/RestaurantService.asmx"
 * WebService a Firebird
 */
-(NSString*)callWebServiceWithJSONParameters:(NSString*) parameters
{
  
    NSURL *url = [NSURL URLWithString:_webserviceURL];
   
    
    if (_userName == nil)
        _userName = @"";
    
    if (_password == nil) 
        _password = @"";
    
    
    //Armamos el string soap (tomado de la definicion del web method) que vamos a mandar a ejecutar.
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Header>"
                             "<RestaurantServiceAuthHeader xmlns=\"http://tempuri.org/\">"
                             "<UserName>%@</UserName>"
                             "<Password>%@</Password>"
                             "</RestaurantServiceAuthHeader>"
                             "</soap:Header>"
                             "<soap:Body>"
                             "<wmExecProcedure xmlns=\"http://tempuri.org/\">"
                             "<procedureName>%@</procedureName>"
                             "<dataBase>%@</dataBase>"
                             "<JSONParameters>%@</JSONParameters>"
                             "</wmExecProcedure>"
                             "</soap:Body>"
                             "</soap:Envelope>",_userName,_password, _name, _database, parameters];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *contentLenght = [NSString stringWithFormat:@"%d", [soapMessage length]];
       
        
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];    
    [request addValue:contentLenght forHTTPHeaderField:@"Content-Length"];    
    [request addValue:@"http://tempuri.org/wmExecProcedure" forHTTPHeaderField:@"SOAPAction"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
    NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error: nil];
    
    NSString *responseMessage;
    
    
    if (responseData == nil) 
    {      
        
        responseMessage = @"<error>The application can not establish connection with the server, please try again later.</error>";
        
    }
    else 
    {
        responseMessage = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    }
    
    return responseMessage;
    
   
}



// Ejecutamos el web service generico
/*
 * aitzac, 16-Oct-2014
 * Metodo para el webservice "http://wdev.royalresorts.local/MobileService/MobileService.asmx"
 * WebSevice a Microsoft SQL Server
 */
-(NSString*)callWebServiceMobileWithJSONParameters:(NSString*) parameters
{
    
    NSURL *url = [NSURL URLWithString:_webserviceURL];
    
    
    if (_userName == nil)
        _userName = @"";
    
    if (_password == nil)
        _password = @"";
    
    NSString *spName = [[NSString alloc] initWithFormat:@"%@.%@", _schema,_name];
    
    
    //Armamos el string soap (tomado de la definicion del web method) que vamos a mandar a ejecutar.
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Header>"
                             "<iOSAuthHeader xmlns=\"MobileService\">"
                             "<UserName>%@</UserName>"
                             "<Password>%@</Password>"
                             "</iOSAuthHeader>"
                             "</soap:Header>"
                             "<soap:Body>"
                             "<wmExecProcedure xmlns=\"MobileService\">"
                             "<strProcedureName>%@</strProcedureName>"
                             "<strDataBaseName>%@</strDataBaseName>"
                             "<strJSONParameters>%@</strJSONParameters>"
                             "<strUserName>%@</strUserName>"
                             "<strUserPassWord>%@</strUserPassWord>"
                             "</wmExecProcedure>"
                             "</soap:Body>"
                             "</soap:Envelope>",_userName,_password, spName, _database, parameters, _userNameMobile, _passwordMobile];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *contentLenght = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:contentLenght forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"MobileService/wmExecProcedure" forHTTPHeaderField:@"SOAPAction"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error: nil];
    
    NSString *responseMessage;
    
    
    /*if (responseData == nil)
    {
        
        responseMessage = @"<error>The application can not establish connection with the server, please try again later.</error>";
        
    }
    else
    {
        responseMessage = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    }*/
    
    return [[NSString alloc] initWithData:[self sendSynchronousRequest:request returningResponse:nil error:nil] encoding:NSUTF8StringEncoding];;
    
}

-(NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(__autoreleasing NSURLResponse **)responsePtr
                             error:(__autoreleasing NSError **)errorPtr {
    dispatch_semaphore_t    sem;
    __block NSData *        result;
    
    result = nil;
    
    sem = dispatch_semaphore_create(0);
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                         if (errorPtr != NULL) {
                                             *errorPtr = error;
                                         }
                                         if (responsePtr != NULL) {
                                             *responsePtr = response;
                                         }
                                         if (error == nil) {
                                             result = data;
                                         }
                                         dispatch_semaphore_signal(sem);
                                     }] resume];
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return result;
}

//Metodo para el WebService de Firebird
-(RRDataSet*) execWithResult:(NSString**) result
{

    NSString *parameters = [self getParametersInJSONFormat];
    NSString *responseString= [self callWebServiceWithJSONParameters:parameters];
    NSRange range;
    RRDataSet *datos;
    
    //Verificamos si hubo algun error al intentar hacer el llamado al web service
    if ([responseString hasPrefix:@"<error>"])
    {
        range = [responseString rangeOfString:@"<error>" options:NSCaseInsensitiveSearch];
        
        *result = [[responseString substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    }
    else 
    {
        
        range = [responseString rangeOfString:@"<soap:Fault>" options:NSCaseInsensitiveSearch];
        
        
        //Verificamos si hubo un error dentro de la ejecucion del web service.
        if (range.location != NSNotFound)
        {   
            NSLog(@"%@",responseString);        
            *result=@"Server was unable to process request.";
        }
        else
        {
            
            //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
            RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmExecProcedureResult"];
            [parser startParse:responseString];
             
            
            datos = [[RRDataSet alloc] initWithJSONString:parser.json];

            *result = @"Successful Operation";
            parser = nil;
    
        }
    }    
    

    parameters = nil;    

    
    return datos;
}


//Metodo para el WebService de Microsoft SQL Server
-(RRDataSet*) execMobileWithResult:(NSString**) result
{
    
    NSString *parameters = [self getParametersInJSONFormat];
    NSString *responseString= [self callWebServiceMobileWithJSONParameters:parameters];
    NSRange range;
    RRDataSet *datos;
    
    //Verificamos si hubo algun error al intentar hacer el llamado al web service
    if ([responseString hasPrefix:@"<error>"])
    {
        range = [responseString rangeOfString:@"<error>" options:NSCaseInsensitiveSearch];
        
        *result = [[responseString substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
    }
    else
    {
        
        range = [responseString rangeOfString:@"<soap:Fault>" options:NSCaseInsensitiveSearch];
        
         //Verificamos si hubo un error dentro de la ejecucion del web service.
         if (range.location != NSNotFound)
         {
         NSLog(@"%@",responseString);
         *result=@"Server was unable to process request.";
         }
        
        else
       {
            
            //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
            RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmExecProcedureResult"];
            [parser startParse:responseString];
            
            
           datos = [[RRDataSet alloc] initWithJSONString:parser.json];
            
            *result = @"Successful Operation";
            parser = nil;
            
        }
    }
    
    
    parameters = nil;
    
    if (datos==nil){

        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmExecProcedureResult"];
        [parser startParse:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><wmExecProcedureResponse xmlns=\"MobileService\"><wmExecProcedureResult>[{\"iRes\":\"-1\",\"sRes\":\"\"}]&amp;SEP&amp;[{\"Result\":\"-10\",\"ResultDesc\":\"The application can not establish connection with the server, please try again later.\",\"PersonaID\":\"\",\"Gender\":\"\",\"FirstName\":\"\",\"LastName\":\"\",\"FullName\":\"\",\"PeopleType\":\"\",\"DefaultLaguage\":\"\",\"Email\":\"\",\"PinNo\":\"\",\"Field1\":\"\",\"Field2\":\"\",\"Field3\":\"\",\"Field4\":\"\",\"Field5\":\"\"}]</wmExecProcedureResult></wmExecProcedureResponse></soap:Body></soap:Envelope>"];
        
        datos = [[RRDataSet alloc] initWithJSONString:parser.json];
        
    }
    
    return datos;
}

//Metodo para el WebService de Microsoft SQL Server
-(RRDataSet*) wmSendEmailWebDocument:(NSString**) result
{
    
    NSString *parameters = [self getParametersInJSONFormat];
    NSString *responseString= [self callWebServiceMobileWithJSONParameters:parameters];
    NSRange range;
    RRDataSet *datos;
    
    //Verificamos si hubo algun error al intentar hacer el llamado al web service
    if ([responseString hasPrefix:@"<error>"])
    {
        range = [responseString rangeOfString:@"<error>" options:NSCaseInsensitiveSearch];
        
        *result = [[responseString substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
    }
    else
    {
        
        range = [responseString rangeOfString:@"<soap:Fault>" options:NSCaseInsensitiveSearch];
        
        //Verificamos si hubo un error dentro de la ejecucion del web service.
        if (range.location != NSNotFound)
        {
            NSLog(@"%@",responseString);
            *result=@"Server was unable to process request.";
        }
        
        else
        {
            
            //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
            RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmSendEmailWebDocument"];
            [parser startParse:responseString];
            
            
            datos = [[RRDataSet alloc] initWithJSONString:parser.json];
            
            *result = @"Successful Operation";
            parser = nil;
            
        }
    }
    
    
    parameters = nil;
    
    
    return datos;
}


@end
