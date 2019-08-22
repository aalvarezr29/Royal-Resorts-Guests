//
//  RRWebServiceParser.h
//  SPA
//
//  Created by Ernesto Fuentes on 6/13/12.
//  Copyright (c) 2012 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRWebServiceParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *revParser;
    NSMutableString *currentElement;
}

// Esta propiedad devolvera la cadena json que se encuentre dentro del xml proveniente del web service
@property (nonatomic, strong) NSString* json;

-(void) startParse:(NSString *) xml;
-(RRWebServiceParser*) initWithTokenResult:(NSString*) token;

@end
