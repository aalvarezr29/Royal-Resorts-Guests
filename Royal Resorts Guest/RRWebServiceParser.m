//
//  RRWebServiceParser.m
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import "RRWebServiceParser.h"

//Esta clase parsea el xml devuelve por el web service de .net para extraer la cadena JSON que nos interesa.
@implementation RRWebServiceParser
{
@private
    NSString * _tokenResult;
    
}


-(RRWebServiceParser*) initWithTokenResult:(NSString *)token
{

    _tokenResult = token;
    return self;
    
}

- (void) parser: (NSXMLParser *) parser 
didStartElement: (NSString *) elementName
   namespaceURI: (NSString *) namespaceURI
  qualifiedName: (NSString *) qName
     attributes: (NSDictionary *) attributeDict
{    
	//Aqui podriamos leer los atributos de un nodo xml, en este caso no lo necesitamos...
    
}


- (void) parser: (NSXMLParser *) parser 
  didEndElement: (NSString *) elementName
   namespaceURI: (NSString *) namespaceURI
  qualifiedName: (NSString *) qName{  
	
    //se evalua que si el nodo que esta terminando coincide con el que nos pasaron por parametro para setear el resultado.
    if ([elementName isEqualToString:_tokenResult])
    {      
        
        
        _json = [[NSString alloc] initWithString:currentElement];
        
    }    
      
    currentElement = nil;
	
}

- (void) parser: (NSXMLParser *) parser foundCharacters: (NSString *) string{
    
	if(!currentElement)
		currentElement = [[NSMutableString alloc] initWithString:string];
	else
		[currentElement appendString:string ];       
}

-(void) startParse:(NSString*) xml
{
    NSData * data=[xml dataUsingEncoding:NSUTF8StringEncoding];
       
    revParser = [[NSXMLParser alloc] initWithData:data];
        
    [revParser setDelegate:self];
    [revParser setShouldProcessNamespaces:NO];
    [revParser setShouldReportNamespacePrefixes:NO];
    [revParser setShouldResolveExternalEntities:YES];
    [revParser parse];       
    
}

@end
