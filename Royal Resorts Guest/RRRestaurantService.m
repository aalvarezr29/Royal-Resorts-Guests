//
//  RRRestaurantService.m
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/19/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import "RRRestaurantService.h"
#import "RRWebServiceParser.h"
#import "RRDataSet.h"
#import "RRStoredProcedure.h"
#import "SBJson.h"

@implementation RRRestaurantService
{
    @private NSString * _webServiceURL;
    @private NSString * _Host;
    @private NSString * _userNameMobile;
    @private NSString * _passwordMobile;
}

@synthesize soapMessage, webResponseData, currentElement, strMsj;

-(RRRestaurantService*) initWithURL:(NSString*) webServiceURL Host:(NSString*) Host userNameMobile:(NSString *) userNameMobile passwordMobile:(NSString*) passwordMobile
{
    _webServiceURL = webServiceURL;
    _Host = Host;
    _userNameMobile = userNameMobile;
    _passwordMobile = passwordMobile;
    
    return self;
}

/*-(RRDataSet *) spGetLoginBy:(NSString*) iType Param1:(NSString*) Param1 Param2:(NSString*) Param2 Param3:(NSString*) Param3 sNotificationToken:(NSString*) sNotificationToken
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar

    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetLoginBy" Schema:@"dbo" DataBase:@"CDRPRD" WebServiceURL:_webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"Param1" Direction:IN Type:VARCHAR Value:Param1 Precision:@"60"];
    [sp addParameterWithName:@"Param2" Direction:IN Type:VARCHAR Value:Param2 Precision:@"60"];
    [sp addParameterWithName:@"Param3" Direction:IN Type:VARCHAR Value:Param3 Precision:@"60"];
    [sp addParameterWithName:@"sNotificationToken" Direction:IN Type:VARCHAR Value:sNotificationToken Precision:@"200"];
    
    return [sp execMobileWithResult:&result];
    
}*/

-(RRDataSet *) spGetLoginBy:(NSString*) iType Param1:(NSString*) Param1 Param2:(NSString*) Param2 Param3:(NSString*) Param3
{
    NSString *result;
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetLoginBy" Schema:@"dbo" DataBase:@"CDRPRD" WebServiceURL:_webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"Param1" Direction:IN Type:VARCHAR Value:Param1 Precision:@"60"];
    [sp addParameterWithName:@"Param2" Direction:IN Type:VARCHAR Value:Param2 Precision:@"60"];
    [sp addParameterWithName:@"Param3" Direction:IN Type:VARCHAR Value:Param3 Precision:@"60"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetPeople:(NSString*) iType PeopleID:(NSString*) PeopleID
{
    NSString *result;

    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetPeopleForApp" Schema:@"dbo" DataBase:@"CDRPRD" WebServiceURL:_webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"PeopleID" Direction:IN Type:INT Value:PeopleID ];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetPinRecovery:(NSString*) iType Param1:(NSString*) Param1 Param2:(NSString*) Param2
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar
    
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetPinRecovery" Schema:@"dbo" DataBase:@"CDRPRD" WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:Param1 Precision:@"60"];
    [sp addParameterWithName:@"Email" Direction:IN Type:VARCHAR Value:Param2 Precision:@"60"];
    
    return [sp execMobileWithResult:&result];
    
    
}

-(NSString *)wmSendEmailWebDocument:(NSString*) strEmailTo strLenguageCode:(NSString*) strLenguageCode Database:(NSString*) Database WebDocumentCode:(NSString*) WebDocumentCode WebDocumentValue1:(NSString*) WebDocumentValue1 WebDocumentValue2:(NSString*) WebDocumentValue2;
{
    
    NSString *strResult = @"";

    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmSendEmailWebDocument xmlns=\"MobileService\">"
                   "<strEmailTo>%@</strEmailTo>"
                   "<strLenguageCode>%@</strLenguageCode>"
                   "<Database>%@</Database>"
                   "<WebDocumentCode>%@</WebDocumentCode>"
                   "<WebDocumentValue1>%@</WebDocumentValue1>"
                   "<WebDocumentValue2>%@</WebDocumentValue2>"
                   "<strUserNameWM>%@</strUserNameWM>"
                   "<strUserPassWord>%@</strUserPassWord>"
                   "</wmSendEmailWebDocument>"
                   "</soap:Body>"
                   "</soap:Envelope>",strEmailTo, strLenguageCode,Database,WebDocumentCode,WebDocumentValue1,WebDocumentValue2,_userNameMobile,_passwordMobile];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];

    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmSendEmailWebDocument" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    /*NSURLConnection *connection =
    [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        webResponseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }*/
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
 
            
            //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
            RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmSendEmailWebDocumentResult"];
            
            [parser startParse:responseString];
            
            strResult = parser.json;

        
    }

    
    return strResult;
    
}

-(RRDataSet *) spGetGuestStay:(NSString*) iType PersonalID:(NSString*) PersonalID AppCode:(NSString*) AppCode DataBase:(NSString*) DataBase
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar

    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetGuestStay" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"PersonalID" Direction:IN Type:VARCHAR Value:PersonalID Precision:@"60"];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"40"];
    
    return [sp execMobileWithResult:&result];

}

-(RRDataSet *) spUpdPeopleChannel:(NSString*) iType AppCode:(NSString*) AppCode ifkPeopleID:(NSString*) ifkPeopleID ifkChannelID:(NSString*) ifkChannelID ynActive:(NSString *) ynActive DataBase:(NSString*) DataBase
{
    NSString *result;
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spUpdPeopleChannel" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"strAppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"20"];
    [sp addParameterWithName:@"ifkPeopleID" Direction:IN Type:VARCHAR Value:ifkPeopleID Precision:@"60"];
    [sp addParameterWithName:@"ifkChannelID" Direction:IN Type:VARCHAR Value:ifkChannelID Precision:@"60"];
    [sp addParameterWithName:@"ynActive" Direction:IN Type:INT Value:ynActive];
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spAddFollowUp:(NSString*) unitcode stayinfoID:(NSString*) stayinfoID iPeopleID:(NSString*) iPeopleID fTypeID:(NSString*) fTypeID reqShort:(NSString*) reqShort reqlong:(NSString*) reqlong Solution:(NSString*) Solution expect:(NSString*) expect finish:(NSString*) finish statusID:(NSString*) statusID DataBase:(NSString*) DataBase
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spAddFollowUp" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"unitcode" Direction:IN Type:VARCHAR Value:unitcode Precision:@"10"];
    [sp addParameterWithName:@"stayinfoID" Direction:IN Type:INT Value:stayinfoID];
    [sp addParameterWithName:@"iPeopleID" Direction:IN Type:VARCHAR Value:iPeopleID Precision:@"40"];
    [sp addParameterWithName:@"fTypeID" Direction:IN Type:INT Value:fTypeID];
    [sp addParameterWithName:@"reqShort" Direction:IN Type:VARCHAR Value:reqShort Precision:@"50"];
    [sp addParameterWithName:@"reqlong" Direction:IN Type:VARCHAR Value:reqlong Precision:@"8000"];
    [sp addParameterWithName:@"Solution" Direction:IN Type:VARCHAR Value:Solution Precision:@"8000"];
    [sp addParameterWithName:@"expect" Direction:IN Type:VARCHAR Value:expect Precision:@"20"];
    [sp addParameterWithName:@"finish" Direction:IN Type:VARCHAR Value:finish Precision:@"20"];
    [sp addParameterWithName:@"statusID" Direction:IN Type:INT Value:statusID];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spSetAppPeoplePushToken:(NSString*) iType PeopleID:(NSString*) PeopleID Token:(NSString*) Token osCode:(NSString*) osCode AppCode:(NSString*) AppCode DataBase:(NSString*) DataBase
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spSetAppPeoplePushToken" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"20"];
    [sp addParameterWithName:@"PeopleID" Direction:IN Type:INT Value:PeopleID];
    [sp addParameterWithName:@"Token" Direction:IN Type:VARCHAR Value:Token Precision:@"1000"];
    [sp addParameterWithName:@"OSCode" Direction:IN Type:VARCHAR Value:osCode Precision:@"10"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetAppPeopleChannelVw:(NSString*) iType AppCode:(NSString*) AppCode PeopleID:(NSString*) PeopleID DataBase:(NSString*) DataBase
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetAppPeopleChannelVw" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"20"];
    [sp addParameterWithName:@"PeopleID" Direction:IN Type:INT Value:PeopleID];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spSetAppPeopleChannel:(NSString*) iType AppCode:(NSString*) AppCode PeopleID:(NSString*) PeopleID pkChannelID:(NSString*) pkChannelID DataBase:(NSString*) DataBase
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spSetAppPeopleChannel" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"20"];
    [sp addParameterWithName:@"PeopleID" Direction:IN Type:INT Value:PeopleID];
    [sp addParameterWithName:@"pkChannelID" Direction:IN Type:INT Value:pkChannelID];
    
    return [sp execMobileWithResult:&result];
    
}


-(NSString *) wmCallAddFollowUp:(NSString*) strDataBase unitcode:(NSString*) unitcode stayinfoID:(NSString*) stayinfoID iPeopleID:(NSString*) iPeopleID fTypeID:(NSString*) fTypeID reqShort:(NSString*) reqShort reqlong:(NSString*) reqlong Solution:(NSString*) Solution expect:(NSString*) expect finish:(NSString*) finish statusID:(NSString*) statusID strLenguageCode:(NSString*) strLenguageCode strDocumentCode:(NSString*) strDocumentCode strPeopleEmail:(NSString*) strPeopleEmail
{
    NSString *strResult = @"";
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmCallAddFollowUp xmlns=\"MobileService\">"
                   "<strDataBase>%@</strDataBase>"
                   "<unitcode>%@</unitcode>"
                   "<stayinfoID>%@</stayinfoID>"
                   "<iPeopleID>%@</iPeopleID>"
                   "<fTypeID>%@</fTypeID>"
                   "<reqShort>%@</reqShort>"
                   "<reqlong>%@</reqlong>"
                   "<Solution>%@</Solution>"
                   "<expect>%@</expect>"
                   "<finish>%@</finish>"
                   "<statusID>%@</statusID>"
                   "<strLenguaje>%@</strLenguaje>"
                   "<strDocumentCode>%@</strDocumentCode>"
                   "<strUserNameWM>%@</strUserNameWM>"
                   "<strUserPassWord>%@</strUserPassWord>"
                   "<strPeopleEmail>%@</strPeopleEmail>"
                   "</wmCallAddFollowUp>"
                   "</soap:Body>"
                   "</soap:Envelope>",strDataBase,unitcode,stayinfoID,iPeopleID,fTypeID,reqShort,reqlong,Solution,expect,finish,statusID,strLenguageCode,strDocumentCode,_userNameMobile,_passwordMobile,strPeopleEmail];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmCallAddFollowUp" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmCallAddFollowUpResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        
    }
    
    
    return strResult;
    
    
}
-(RRDataSet *) spGetGuestAccount:(NSString*) iType AppCode:(NSString*) AppCode PersonalID:(NSString*) PersonalID StayInfoID:(NSString*) StayInfoID LastAccTrxID:(NSString*) LastAccTrxID DataBase:(NSString*) DataBase
{
    NSString *result;

    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetGuestAccount" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"40"];
    [sp addParameterWithName:@"PersonalID" Direction:IN Type:VARCHAR Value:PersonalID Precision:@"60"];
    [sp addParameterWithName:@"StayInfoID" Direction:IN Type:VARCHAR Value:StayInfoID Precision:@"60"];
    [sp addParameterWithName:@"LastAccTrxID" Direction:IN Type:VARCHAR Value:LastAccTrxID Precision:@"60"];
    
    return [sp execMobileWithResult:&result];

}

-(RRDataSet *) spGetVoucherDetail:(NSString*) iType AppCode:(NSString*) AppCode PersonalID:(NSString*) PersonalID iValue:(NSString*) iValue DataBase:(NSString*) DataBase
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetVoucherDetail" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"40"];
    [sp addParameterWithName:@"PersonalID" Direction:IN Type:VARCHAR Value:PersonalID Precision:@"60"];
    [sp addParameterWithName:@"iValue" Direction:IN Type:VARCHAR Value:iValue Precision:@"60"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetPreRegReservation:(NSString*) iType iPeopleID:(NSString*) iPeopleID ConfirmationCode:(NSString*) ConfirmationCode Fname:(NSString*) Fname LName:(NSString*) LName CheckinDt:(NSString*) CheckinDt ResortCode:(NSString*) ResortCode DataBase:(NSString*) DataBase
{
    NSString *result;

    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetPreRegReservation" Schema:@"Res" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"iPeopleID" Direction:IN Type:INT Value:iPeopleID];
    [sp addParameterWithName:@"ConfirmationCode" Direction:IN Type:VARCHAR Value:ConfirmationCode Precision:@"40"];
    [sp addParameterWithName:@"Fname" Direction:IN Type:VARCHAR Value:Fname Precision:@"60"];
    [sp addParameterWithName:@"LName" Direction:IN Type:VARCHAR Value:LName Precision:@"60"];
    [sp addParameterWithName:@"CheckinDt" Direction:IN Type:VARCHAR Value:CheckinDt Precision:@"8"];
    [sp addParameterWithName:@"ResortCode" Direction:IN Type:VARCHAR Value:ResortCode Precision:@"10"];
    
    return [sp execMobileWithResult:&result];

}

-(NSString *) wmPaymentCC:(NSString*) iType AppCode:(NSString*) AppCode DataBase:(NSString*) DataBase StayInfoID:(NSString*) StayInfoID PersonalID:(NSString*) PersonalID Amount:(NSString*) Amount strCc:(NSString*) strCc strExpDate:(NSString*) strExpDate strCvc2:(NSString*) strCvc2 intAccId:(NSString*) intAccId intTrxType:(NSString*) intTrxType strTrxDate:(NSString*) strTrxDate strReference:(NSString*) strReference strMail:(NSString*) strMail strLenguageCode:(NSString*) strLenguageCode PlaceID:(NSString*) PlaceID strForceMexicanCc:(NSString*) strForceMexicanCc strDocumentCode:(NSString*) strDocumentCode strFName:(NSString*) strFName strLname:(NSString*) strLname strCurrency:(NSString*) strCurrency
{
    NSString *strResult = @"";
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmPaymentCC xmlns=\"MobileService\">"
                   "<strDataBase>%@</strDataBase>"
                   "<strStayInfoID>%@</strStayInfoID>"
                   "<strPeopleFDeskID>%@</strPeopleFDeskID>"
                   "<strAmount>%@</strAmount>"
                   "<strCc>%@</strCc>"
                   "<strExpDate>%@</strExpDate>"
                   "<strCvc2>%@</strCvc2>"
                   "<intAccId>%@</intAccId>"
                   "<intTrxType>%@</intTrxType>"
                   "<strTrxDate>%@</strTrxDate>"
                   "<strReference>%@</strReference>"
                   "<strPeopleEmail>%@</strPeopleEmail>"
                   "<strLenguaje>%@</strLenguaje>"
                   "<intPlaceId>%@</intPlaceId>"
                   "<strForceMexicanCc>%@</strForceMexicanCc>"
                   "<strUserNameWM>%@</strUserNameWM>"
                   "<strUserPassWord>%@</strUserPassWord>"
                   "<strDocumentCode>%@</strDocumentCode>"
                   "<strFName>%@</strFName>"
                   "<strLname>%@</strLname>"
                   "<strCurrency>%@</strCurrency>"
                   "</wmPaymentCC>"
                   "</soap:Body>"
                   "</soap:Envelope>",DataBase, StayInfoID, PersonalID, Amount, strCc, strExpDate, strCvc2, intAccId, intTrxType, strTrxDate, strReference, strMail, strLenguageCode, PlaceID, strForceMexicanCc, _userNameMobile, _passwordMobile, strDocumentCode, strFName, strLname, strCurrency];

    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmPaymentCC" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
 
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmPaymentCCResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        
    }

    
    return strResult;

    
}

-(NSString *) wmCallPostAuthMobile:(NSString*) iType strDataBase:(NSString*) strDataBase intAccTrxId:(NSString*) intAccTrxId dblAmount:(NSString*) dblAmount strTrxCode:(NSString*) strTrxCode strTrxTest:(NSString*) strTrxTest strMail:(NSString*) strMail strLenguageCode:(NSString*) strLenguageCode PersonalID:(NSString*) PersonalID strDocumentCode:(NSString*) strDocumentCode
{
    NSString *strResult = @"";
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmCallPostAuthMobile xmlns=\"MobileService\">"
                   "<strDataBase>%@</strDataBase>"
                   "<intAccTrxid>%@</intAccTrxid>"
                   "<dblAmount>%@</dblAmount>"
                   "<strTrxCode>%@</strTrxCode>"
                   "<strTrxTest>%@</strTrxTest>"
                   "<strPeopleEmail>%@</strPeopleEmail>"
                   "<strLenguaje>%@</strLenguaje>"
                   "<strPeopleFDeskID>%@</strPeopleFDeskID>"
                   "<strDocumentCode>%@</strDocumentCode>"
                   "<strUserNameWM>%@</strUserNameWM>"
                   "<strUserPassWord>%@</strUserPassWord>"
                   "</wmCallPostAuthMobile>"
                   "</soap:Body>"
                   "</soap:Envelope>",strDataBase, intAccTrxId, dblAmount, strTrxCode.description, strTrxTest.description,strMail,strLenguageCode,PersonalID,strDocumentCode,_userNameMobile,_passwordMobile];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmCallPostAuthMobile" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];

        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmCallPostAuthMobileResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        if (strResult == nil){
            strResult = @"";
        }

    }
    
    
    return strResult;
    
    
}
-(RRDataSet *) spAddFdeskCheckOut:(NSString*) StayInfoID iResult:(NSString *)iResult sResult:(NSString *)sResult DataBase:(NSString*) DataBase
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spAddFdeskCheckOut" Schema:@"Res" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iStayInfoID" Direction:IN Type:INT Value:StayInfoID];
    [sp addParameterWithName:@"iCompleted" Direction:OUT Type:INT Value:iResult];
    [sp addParameterWithName:@"sMsg" Direction:OUT Type:VARCHAR Value:sResult Precision:@"100"];
    
    return [sp execMobileWithResult:&result];
    
}

-(NSString *) wmPosCheckOut:(NSString*) iType strStayInfoID:(NSString*) strStayInfoID strAccID:(NSString*) strAccID strArrivalDate:(NSString*) strArrivalDate strDepartureDate:(NSString*) strDepartureDate strBellBoydate:(NSString*) strBellBoydate strDataBase:(NSString*) strDataBase strBellBoyBag1:(NSString*) strBellBoyBag1
{
    NSString *strResult = @"";
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmPosCheckOut xmlns=\"MobileService\">"
                   "<iType>%@</iType>"
                   "<strStayInfoID>%@</strStayInfoID>"
                   "<strAccID>%@</strAccID>"
                   "<strArrivalDate>%@</strArrivalDate>"
                   "<strDepartureDate>%@</strDepartureDate>"
                   "<strBellBoydate>%@</strBellBoydate>"
                   "<strBellBoyBag1>%@</strBellBoyBag1>"
                   "<strDataBase>%@</strDataBase>"
                   "<strUserNameWM>%@</strUserNameWM>"
                   "<strUserPassWord>%@</strUserPassWord>"
                   "</wmPosCheckOut>"
                   "</soap:Body>"
                   "</soap:Envelope>",iType, strStayInfoID, strAccID, strArrivalDate, strDepartureDate, strBellBoydate, strBellBoyBag1, strDataBase,_userNameMobile,_passwordMobile];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmPosCheckOut" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];

        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmPosCheckOutResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        
    }
    
    
    return strResult;
    
    
}

    -(RRDataSet *) wmGetRewardBalance:(NSString*) strDataBase strPersonalID:(NSString*) strPersonalID ynDecryCred:(NSString*) ynDecryCred
    {
        NSString *strResult = @"";
        RRDataSet *datos;
        
        //first create the soap envelope
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                       "<soap:Body>"
                       "<wmGetRewardBalance xmlns=\"MobileService\">"
                       "<sDBName>%@</sDBName>"
                       "<iPersonaId>%@</iPersonaId>"
                       "<ynDecryCred>%@</ynDecryCred>"
                       "</wmGetRewardBalance>"
                       "</soap:Body>"
                       "</soap:Envelope>", strDataBase, strPersonalID, ynDecryCred];
        
        //Now create a request to the URL
        NSURL *url = [NSURL URLWithString:_webServiceURL];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
        
        //ad required headers to the request
        [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"MobileService/wmGetRewardBalance" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
        
        NSString *responseString;
        
        if (responseData == nil)
        {
            return strResult;
            
        }
        else
        {
            
            responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
            RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmGetRewardBalanceResult"];
            
            [parser startParse:responseString];
            
            strResult = parser.json;
            
            datos = [[RRDataSet alloc] initWithJSONString:parser.json];
            
        }
        
        
        return datos;
        
        
    }

-(RRDataSet *) wmApplyRewardCharge:(NSString*) strDataBase strAccId:(NSString*) strAccId strTypeCode:(NSString*) strTypeCode iPersonaId:(NSString*) iPersonaId iKeycardID:(NSString*) iKeycardID strPlaceCode:(NSString*) strPlaceCode mAmount:(NSString*) mAmount iStoreId:(NSString*) iStoreId sCurrencyCode:(NSString*) sCurrencyCode sDocument:(NSString*) sDocument sRemark:(NSString*) sRemark dTrxDate:(NSString*) dTrxDate sUserLogin:(NSString*) sUserLogin
{
    NSString *strResult = @"";
    RRDataSet *datos;
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmApplyRewardCharge xmlns=\"MobileService\">"
                   "<sDBName>%@</sDBName>"
                   "<strAccId>%@</strAccId>"
                   "<strTypeCode>%@</strTypeCode>"
                   "<iPersonaId>%@</iPersonaId>"
                   "<iKeycardID>%@</iKeycardID>"
                   "<strPlaceCode>%@</strPlaceCode>"
                   "<mAmount>%@</mAmount>"
                   "<iStoreId>%@</iStoreId>"
                   "<sCurrencyCode>%@</sCurrencyCode>"
                   "<sDocument>%@</sDocument>"
                   "<sRemark>%@</sRemark>"
                   "<dTrxDate>%@</dTrxDate>"
                   "<sUserLogin>%@</sUserLogin>"
                   "</wmApplyRewardCharge>"
                   "</soap:Body>"
                   "</soap:Envelope>", strDataBase, strAccId, strTypeCode, iPersonaId, iKeycardID, strPlaceCode, mAmount, iStoreId, sCurrencyCode, sDocument, sRemark, dTrxDate, sUserLogin];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmApplyRewardCharge" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmApplyRewardChargeResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        datos = [[RRDataSet alloc] initWithJSONString:parser.json];
        
    }
    
    
    return datos;
    
    
}

-(RRDataSet *) wmGetCalagoHoteles:(NSString*) sClientToken sAppToken:(NSString*) sAppToken sleguage:(NSString*) sleguage iModo:(NSString*) iModo strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5
{
    NSString *strResult = @"";
    RRDataSet *datos;
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmGetCalagoHoteles xmlns=\"MobileService\">"
                   "<sClientToken>%@</sClientToken>"
                   "<sAppToken>%@</sAppToken>"
                   "<sleguage>%@</sleguage>"
                   "<iModo>%@</iModo>"
                   "<strToken1>%@</strToken1>"
                   "<strToken2>%@</strToken2>"
                   "<strToken3>%@</strToken3>"
                   "<strToken4>%@</strToken4>"
                   "<strToken5>%@</strToken5>"
                   "</wmGetCalagoHoteles>"
                   "</soap:Body>"
                   "</soap:Envelope>", sClientToken, sAppToken, sleguage, iModo, strToken1, strToken2, strToken3, strToken4, strToken5];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmGetCalagoHoteles" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmGetCalagoHotelesResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        datos = [[RRDataSet alloc] initWithJSONString:parser.json];
        
    }
    
    
    return datos;
    
    
}

-(RRDataSet *) wmGetCatalogItemsVtm:(NSString*) sLanguageCode sItemCode:(NSString*) sItemCode sAttributeCodes:(NSString*) sAttributeCodes iTransferTypeID:(NSString*) iTransferTypeID sItemTypeCodes:(NSString*) sItemTypeCodes sHotelArrivalCode:(NSString*) sHotelArrivalCode sHotelDeparturCode:(NSString*) sHotelDeparturCode iNumPax:(NSString*) iNumPax sClientToken:(NSString*) sClientToken sAppToken:(NSString*) sAppToken strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5
{
    NSString *strResult = @"";
    RRDataSet *datos;
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmGetCatalogItemsVtm xmlns=\"MobileService\">"
                   "<sLanguageCode>%@</sLanguageCode>"
                   "<sItemCode>%@</sItemCode>"
                   "<sAttributeCodes>%@</sAttributeCodes>"
                   "<iTransferTypeID>%@</iTransferTypeID>"
                   "<sItemTypeCodes>%@</sItemTypeCodes>"
                   "<sHotelArrivalCode>%@</sHotelArrivalCode>"
                   "<sHotelDeparturCode>%@</sHotelDeparturCode>"
                   "<iNumPax>%@</iNumPax>"
                   "<sClientToken>%@</sClientToken>"
                   "<sAppToken>%@</sAppToken>"
                    "<strToken1>%@</strToken1>"
                    "<strToken2>%@</strToken2>"
                    "<strToken3>%@</strToken3>"
                    "<strToken4>%@</strToken4>"
                   "<strToken5>%@</strToken5>"
                   "</wmGetCatalogItemsVtm>"
                   "</soap:Body>"
                   "</soap:Envelope>", sLanguageCode, sItemCode, sAttributeCodes, iTransferTypeID, sItemTypeCodes, sHotelArrivalCode, sHotelDeparturCode, iNumPax, sClientToken, sAppToken, strToken1, strToken2, strToken3, strToken4, strToken5];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmGetCatalogItemsVtm" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmGetCatalogItemsVtmResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        datos = [[RRDataSet alloc] initWithJSONString:parser.json];
        
    }
    
    
    return datos;
    
    
}

-(RRDataSet *) wmGetFlightVtmTrans:(NSString*) iModo iOperator:(NSString*) iOperator sFlightTypeCode:(NSString*) sFlightTypeCode strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5
{
    NSString *strResult = @"";
    RRDataSet *datos;
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmGetFlightVtmTrans xmlns=\"MobileService\">"
                   "<iModo>%@</iModo>"
                   "<iOperator>%@</iOperator>"
                   "<sFlightTypeCode>%@</sFlightTypeCode>"
                    "<strToken1>%@</strToken1>"
                    "<strToken2>%@</strToken2>"
                    "<strToken3>%@</strToken3>"
                    "<strToken4>%@</strToken4>"
                   "<strToken5>%@</strToken5>"
                   "</wmGetFlightVtmTrans>"
                   "</soap:Body>"
                   "</soap:Envelope>", iModo, iOperator, sFlightTypeCode, strToken1, strToken2, strToken3, strToken4, strToken5];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmGetFlightVtmTrans" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmGetFlightVtmTransResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        datos = [[RRDataSet alloc] initWithJSONString:parser.json];
        
    }
    
    
    return datos;
    
    
}

-(RRDataSet *) wmAddReservation:(NSString*) sResTypeCode sLanguageCode:(NSString*) sLanguageCode sSourceCode:(NSString*) sSourceCode iPeopleFromCDRID:(NSString*) iPeopleFromCDRID sFname:(NSString*) sFname sLname1:(NSString*) sLname1 sEmailAddress:(NSString*) sEmailAddress sTerminalCode:(NSString*) sTerminalCode sWorkStationCode:(NSString*) sWorkStationCode sUserLogin:(NSString*) sUserLogin iApplicationClient:(NSString*) iApplicationClient IItemVariantID:(NSString*) IItemVariantID iPax:(NSString*) iPax sArrivalHotelCode:(NSString*) sArrivalHotelCode sDepartureHotelCode:(NSString*) sDepartureHotelCode SPaymentTypeCode:(NSString*) SPaymentTypeCode sRoom:(NSString*) sRoom SConfirmationCode:(NSString*) SConfirmationCode dtArrivalDate:(NSString*) dtArrivalDate sArrivalFlightCode:(NSString*) sArrivalFlightCode sArrivalComment:(NSString*) sArrivalComment dtDepartureDate:(NSString*) dtDepartureDate sDepartureFlightCode:(NSString*) sDepartureFlightCode ynArrival:(NSString*) ynArrival iArrivalHotelID:(NSString*) iArrivalHotelID iDepartureHotelID:(NSString*) iDepartureHotelID ynIncludeDetail:(NSString*) ynIncludeDetail SLimitDate:(NSString*) SLimitDate DtDateIn:(NSString*) DtDateIn DtDateOut:(NSString*) DtDateOut STransferTypeCode:(NSString*) STransferTypeCode SWebDocumentCode:(NSString*) SWebDocumentCode SOrigin:(NSString*) SOrigin SDestiny:(NSString*) SDestiny strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5
{
    
    NSString *strResult = @"";
    RRDataSet *datos;
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmAddReservation xmlns=\"MobileService\">"
                   "<sResTypeCode>%@</sResTypeCode>"
                   "<sLanguageCode>%@</sLanguageCode>"
                   "<sSourceCode>%@</sSourceCode>"
                   "<iPeopleFromCDRID>%@</iPeopleFromCDRID>"
                   "<sFname>%@</sFname>"
                   "<sLname1>%@</sLname1>"
                   "<sEmailAddress>%@</sEmailAddress>"
                   "<sTerminalCode>%@</sTerminalCode>"
                   "<sWorkStationCode>%@</sWorkStationCode>"
                   "<sUserLogin>%@</sUserLogin>"
                   "<iApplicationClient>%@</iApplicationClient>"
                   "<IItemVariantID>%@</IItemVariantID>"
                   "<iPax>%@</iPax>"
                   "<sArrivalHotelCode>%@</sArrivalHotelCode>"
                   "<sDepartureHotelCode>%@</sDepartureHotelCode>"
                   "<SPaymentTypeCode>%@</SPaymentTypeCode>"
                   "<sRoom>%@</sRoom>"
                   "<SConfirmationCode>%@</SConfirmationCode>"
                   "<dtArrivalDate>%@</dtArrivalDate>"
                   "<sArrivalFlightCode>%@</sArrivalFlightCode>"
                   "<sArrivalComment>%@</sArrivalComment>"
                   "<dtDepartureDate>%@</dtDepartureDate>"
                   "<sDepartureFlightCode>%@</sDepartureFlightCode>"
                   "<ynArrival>%@</ynArrival>"
                   "<iArrivalHotelID>%@</iArrivalHotelID>"
                   "<iDepartureHotelID>%@</iDepartureHotelID>"
                   "<ynIncludeDetail>%@</ynIncludeDetail>"
                   "<SLimitDate>%@</SLimitDate>"
                   "<DtDateIn>%@</DtDateIn>"
                   "<DtDateOut>%@</DtDateOut>"
                   "<STransferTypeCode>%@</STransferTypeCode>"
                   "<SWebDocumentCode>%@</SWebDocumentCode>"
                   "<SOrigin>%@</SOrigin>"
                   "<SDestiny>%@</SDestiny>"
                   "<strToken1>%@</strToken1>"
                   "<strToken2>%@</strToken2>"
                   "<strToken3>%@</strToken3>"
                   "<strToken4>%@</strToken4>"
                   "<strToken5>%@</strToken5>"
                   "</wmAddReservation>"
                   "</soap:Body>"
                   "</soap:Envelope>", sResTypeCode, sLanguageCode, sSourceCode, iPeopleFromCDRID, sFname, sLname1, sEmailAddress, sTerminalCode, sWorkStationCode, sUserLogin, iApplicationClient,
                   IItemVariantID, iPax, sArrivalHotelCode, sDepartureHotelCode, SPaymentTypeCode, sRoom, SConfirmationCode, dtArrivalDate, sArrivalFlightCode, sArrivalComment,
                   dtDepartureDate, sDepartureFlightCode, ynArrival, iArrivalHotelID, iDepartureHotelID, ynIncludeDetail, SLimitDate, DtDateIn,
                   DtDateOut, STransferTypeCode, SWebDocumentCode, SOrigin, SDestiny, strToken1, strToken2, strToken3, strToken4, strToken5];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmAddReservation" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmAddReservationResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        datos = [[RRDataSet alloc] initWithJSONString:parser.json];
        
    }
    
    
    return datos;
    
}

-(NSString *) wmGetCCExchangeVwPCI:(NSString*) strDataBase strCc:(NSString*) strCc strAccID:(NSString*) strAccID
{
    NSString *strResult = @"";
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmGetCCExchangeVwPCI xmlns=\"MobileService\">"
                   "<strDataBase>%@</strDataBase>"
                   "<strCc>%@</strCc>"
                   "<strAccID>%@</strAccID>"
                   "</wmGetCCExchangeVwPCI>"
                   "</soap:Body>"
                   "</soap:Envelope>",strDataBase,strCc,strAccID];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmGetCCExchangeVwPCI" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;
    
    if (responseData == nil)
    {
        return strResult;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmGetCCExchangeVwPCIResult"];
        
        [parser startParse:responseString];
        
        strResult = parser.json;
        
        
    }
    
    
    return strResult;
    
    
}

-(RRDataSet *) spGetAppStayPeople:(NSString*) iType AppCode:(NSString *)AppCode PersonalID:(NSString *)PersonalID StayInfoID:(NSString *)StayInfoID DataBase:(NSString*) DataBase
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetAppStayPeople" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"40"];
    [sp addParameterWithName:@"PersonalID" Direction:IN Type:VARCHAR Value:PersonalID Precision:@"60"];
    [sp addParameterWithName:@"StayInfoID" Direction:IN Type:VARCHAR Value:StayInfoID Precision:@"60"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetGuestAccPreAuthTrx:(NSString*) iType AppCode:(NSString *)AppCode PersonalID:(NSString *)PersonalID StayInfoID:(NSString *)StayInfoID DataBase:(NSString*) DataBase
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetGuestAccPreAuthTrx" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"40"];
    [sp addParameterWithName:@"PersonalID" Direction:IN Type:VARCHAR Value:PersonalID Precision:@"60"];
    [sp addParameterWithName:@"StayInfoID" Direction:IN Type:VARCHAR Value:StayInfoID Precision:@"60"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetCmbCountry:(NSString*) DataBase
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetCmbCountryForApp" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];

    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetMobileFollowUpVw:(NSString*) iType AppCode:(NSString *)AppCode peopleID:(NSString *)peopleID FollowUpId:(NSString *)FollowUpId DataBase:(NSString*) DataBase sLanguage:(NSString*) sLanguage

{
    
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetMobileFollowUpVw" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"peopleID" Direction:IN Type:INT Value:peopleID];
    [sp addParameterWithName:@"FollowUpId" Direction:IN Type:INT Value:FollowUpId];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"10"];
    [sp addParameterWithName:@"sLanguage" Direction:IN Type:VARCHAR Value:sLanguage Precision:@"3"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetRestaurantDefault:(NSString*) iType PropertyID:(NSString *)PropertyID TypeCode:(NSString *)TypeCode StayInfoID:(NSString *)StayInfoID DataBase:(NSString*) DataBase

{
    
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetRestaurantDefault" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"itype" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"iProperty" Direction:IN Type:INT Value:PropertyID];
    [sp addParameterWithName:@"RestaurantTypeCode" Direction:IN Type:VARCHAR Value:TypeCode Precision:@"20"];
    [sp addParameterWithName:@"iStayInfoID" Direction:IN Type:INT Value:StayInfoID];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetRestaurantAvailability:(NSString*) iType RestaurantCode:(NSString *)RestaurantCode dateTimeStart:(NSString*) dateTimeStart PeopleNo:(NSString *)PeopleNo Children:(NSString *)Children DataBase:(NSString*) DataBase
{
    
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetRestaurantAvailability" Schema:@"CRM" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"itype" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"RestaurantCode" Direction:IN Type:VARCHAR Value:RestaurantCode Precision:@"30"];
    [sp addParameterWithName:@"dateTimeStart" Direction:IN Type:VARCHAR Value:dateTimeStart Precision:@"30"];
    [sp addParameterWithName:@"PeopleNo" Direction:IN Type:INT Value:PeopleNo];
    [sp addParameterWithName:@"Children" Direction:IN Type:INT Value:Children];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spAddRestReservationWeb:(NSString*) iType FirstName:(NSString *)FirstName LastName:(NSString*) LastName Date:(NSString *)Date Time:(NSString *)Time RestaurantCode:(NSString *)RestaurantCode NumAdult:(NSString *)NumAdult NumChildren:(NSString *)NumChildren ynRRGuest:(NSString *)ynRRGuest PropertyCode:(NSString *)PropertyCode HotelName:(NSString *)HotelName RoomNum:(NSString *)RoomNum ynRefine:(NSString *)ynRefine Email:(NSString *)Email Note:(NSString *)Note SourceCode:(NSString *)SourceCode ZoneCode:(NSString *)ZoneCode PRCode:(NSString *)PRCode DataBase:(NSString*) DataBase
{
    
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spAddRestReservationWeb" Schema:@"CRM" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"FirstName" Direction:IN Type:VARCHAR Value:FirstName Precision:@"60"];
    [sp addParameterWithName:@"LastName" Direction:IN Type:VARCHAR Value:LastName Precision:@"60"];
    [sp addParameterWithName:@"Date" Direction:IN Type:VARCHAR Value:Date Precision:@"30"];
    [sp addParameterWithName:@"Time" Direction:IN Type:VARCHAR Value:Time Precision:@"10"];
    [sp addParameterWithName:@"RestaurantCode" Direction:IN Type:VARCHAR Value:RestaurantCode Precision:@"10"];
    [sp addParameterWithName:@"NumAdult" Direction:IN Type:INT Value:NumAdult];
    [sp addParameterWithName:@"NumChildren" Direction:IN Type:INT Value:NumChildren];
    [sp addParameterWithName:@"ynRRGuest" Direction:IN Type:INT Value:ynRRGuest];
    [sp addParameterWithName:@"PropertyCode" Direction:IN Type:VARCHAR Value:PropertyCode Precision:@"3"];
    [sp addParameterWithName:@"HotelName" Direction:IN Type:VARCHAR Value:HotelName Precision:@"60"];
    [sp addParameterWithName:@"RoomNum" Direction:IN Type:VARCHAR Value:RoomNum Precision:@"10"];
    [sp addParameterWithName:@"ynRefine" Direction:IN Type:INT Value:ynRefine];
    [sp addParameterWithName:@"Email" Direction:IN Type:VARCHAR Value:Email Precision:@"100"];
    [sp addParameterWithName:@"Note" Direction:IN Type:VARCHAR Value:Note Precision:@"500"];
    [sp addParameterWithName:@"SourceCode" Direction:IN Type:VARCHAR Value:SourceCode Precision:@"10"];
    [sp addParameterWithName:@"ZoneCode" Direction:IN Type:VARCHAR Value:ZoneCode Precision:@"10"];
    [sp addParameterWithName:@"PRCode" Direction:IN Type:VARCHAR Value:PRCode Precision:@"30"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spSetAppStayPeople:(NSString*) iType AppCode:(NSString *)AppCode UserPersonalID:(NSString *)UserPersonalID StayInfoID:(NSString *)StayInfoID ID:(NSString *)ID FirstName:(NSString *)FirstName MiddleName:(NSString *)MiddleName LastName1:(NSString *)LastName1 LastName2:(NSString *)LastName2 EmailAddress:(NSString *)EmailAddress YearBirthday:(NSString *)YearBirthday ynPrimary:(NSString *)ynPrimary PhoneNo:(NSString *)PhoneNo dtExpectedArrival:(NSString*) dtExpectedArrival pkGuestAgeID:(NSString*) pkGuestAgeID DataBase:(NSString*) DataBase
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spSetAppStayPeople" Schema:@"dbo" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType];
    [sp addParameterWithName:@"AppCode" Direction:IN Type:VARCHAR Value:AppCode Precision:@"40"];
    [sp addParameterWithName:@"UserPersonalID" Direction:IN Type:INT Value:UserPersonalID];
    [sp addParameterWithName:@"StayInfoID" Direction:IN Type:INT Value:StayInfoID];
    [sp addParameterWithName:@"ID" Direction:IN Type:INT Value:ID];
    [sp addParameterWithName:@"FirstName" Direction:IN Type:VARCHAR Value:FirstName Precision:@"132"];
    [sp addParameterWithName:@"MiddleName" Direction:IN Type:VARCHAR Value:MiddleName Precision:@"60"];
    [sp addParameterWithName:@"LastName1" Direction:IN Type:VARCHAR Value:LastName1 Precision:@"60"];
    [sp addParameterWithName:@"LastName2" Direction:IN Type:VARCHAR Value:LastName2 Precision:@"60"];
    [sp addParameterWithName:@"EmailAddress" Direction:IN Type:VARCHAR Value:EmailAddress Precision:@"100"];
    [sp addParameterWithName:@"YearBirthday" Direction:IN Type:INT Value:YearBirthday];
    [sp addParameterWithName:@"ynPrimary" Direction:IN Type:INT Value:ynPrimary];
    [sp addParameterWithName:@"PhoneNo" Direction:IN Type:VARCHAR Value:PhoneNo Precision:@"20"];
    [sp addParameterWithName:@"dtExpectedArrival" Direction:IN Type:VARCHAR Value:dtExpectedArrival Precision:@"20"];
    [sp addParameterWithName:@"pkGuestAgeID" Direction:IN Type:INT Value:pkGuestAgeID];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spAddFdeskAccTrx:(NSString*) DataBase iAccid:(NSString*) iAccid sTrxTypeCode:(NSString *)sTrxTypeCode iKeycardid:(NSString *)iKeycardid sPlacecode:(NSString *)sPlacecode sDocument:(NSString *)sDocument sRemark:(NSString *)sRemark dTrxdate:(NSString *)dTrxdate mSubTotal:(NSString *)mSubTotal mTax1:(NSString *)mTax1 mTax2:(NSString *)mTax2 mTax3:(NSString *)mTax3 mSubtotalExento:(NSString *)mSubtotalExento mSubtotalBaseCero:(NSString *)mSubtotalBaseCero mTip1:(NSString*) mTip1 mTip2:(NSString*) mTip2 mTotal:(NSString*) mTotal sFolioType:(NSString*) sFolioType iAccFolioID:(NSString*) iAccFolioID iCompleted:(NSString*) iCompleted sMsg:(NSString*) sMsg sUserLogin:(NSString*) sUserLogin sOperation:(NSString*) sOperation ynSkipConsumptionLimit:(NSString*) ynSkipConsumptionLimit
{
    NSString *result;
    
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spAddFdeskAccTrx" Schema:@"res" DataBase:DataBase WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iAccid" Direction:IN Type:INT Value:iAccid];
    [sp addParameterWithName:@"sTrxTypeCode" Direction:IN Type:VARCHAR Value:sTrxTypeCode Precision:@"40"];
    [sp addParameterWithName:@"iKeycardid" Direction:IN Type:INT Value:iKeycardid];
    [sp addParameterWithName:@"sPlacecode" Direction:IN Type:VARCHAR Value:sPlacecode Precision:@"10"];
    [sp addParameterWithName:@"sDocument" Direction:IN Type:VARCHAR Value:sDocument Precision:@"60"];
    [sp addParameterWithName:@"sRemark" Direction:IN Type:VARCHAR Value:sRemark Precision:@"60"];
    [sp addParameterWithName:@"dTrxdate" Direction:IN Type:VARCHAR Value:dTrxdate Precision:@"30"];
    [sp addParameterWithName:@"mSubTotal" Direction:IN Type:VARCHAR Value:mSubTotal Precision:@"20"];
    [sp addParameterWithName:@"mTax1" Direction:IN Type:VARCHAR Value:mTax1 Precision:@"20"];
    [sp addParameterWithName:@"mTax2" Direction:IN Type:VARCHAR Value:mTax2 Precision:@"20"];
    [sp addParameterWithName:@"mTax3" Direction:IN Type:VARCHAR Value:mTax3 Precision:@"20"];
    [sp addParameterWithName:@"mSubtotalExento" Direction:IN Type:VARCHAR Value:mSubtotalExento Precision:@"20"];
    [sp addParameterWithName:@"mSubtotalBaseCero" Direction:IN Type:VARCHAR Value:mSubtotalBaseCero Precision:@"20"];
    [sp addParameterWithName:@"mTip1" Direction:IN Type:VARCHAR Value:mTip1 Precision:@"20"];
    [sp addParameterWithName:@"mTip2" Direction:IN Type:VARCHAR Value:mTip2 Precision:@"20"];
    [sp addParameterWithName:@"mTotal" Direction:IN Type:VARCHAR Value:mTotal Precision:@"20"];
    [sp addParameterWithName:@"sFolioType" Direction:IN Type:VARCHAR Value:sFolioType Precision:@"10"];
    [sp addParameterWithName:@"iAccFolioID" Direction:IN Type:INT Value:iAccFolioID];
    [sp addParameterWithName:@"iCompleted" Direction:OUT Type:INT Value:iCompleted];
    [sp addParameterWithName:@"sMsg" Direction:OUT Type:VARCHAR Value:sMsg Precision:@"100"];
    [sp addParameterWithName:@"sUserLogin" Direction:IN Type:VARCHAR Value:sUserLogin Precision:@"12"];
    [sp addParameterWithName:@"sOperation" Direction:IN Type:VARCHAR Value:sOperation Precision:@"1"];
    [sp addParameterWithName:@"ynSkipConsumptionLimit" Direction:IN Type:VARCHAR Value:ynSkipConsumptionLimit Precision:@"1"];
    
    return [sp execMobileWithResult:&result];
    
}

-(RRDataSet *) spGetParseKeysWv:(NSString*) iType
{
    NSString *result;
    //Estamos creando la instancia de RRStoredProcedure para ejecutar el llamado a spGetTableForInvoice que es eL procedimiento encargado de obtener
    //las sillas que se van a facturar
    
    //Para los procedimientos de SQL SERVER, usamos el webservice urlMovileService
    RRStoredProcedure *sp = [[RRStoredProcedure alloc] initWithName:@"spGetParseKeysWv" Schema:@"dbo" DataBase:@"CDRPRD" WebServiceURL: _webServiceURL userNameMobile:_userNameMobile passwordMobile:_passwordMobile];
    
    [sp addParameterWithName:@"iType" Direction:IN Type:INT Value:iType ];
    [sp addParameterWithName:@"iRes" Direction:OUT Type:VARCHAR Value:@"" Precision:@"60"];
    [sp addParameterWithName:@"sRes" Direction:OUT Type:VARCHAR Value:@"" Precision:@"60"];
    
    return [sp execMobileWithResult:&result];
    
    
}

-(RRDataSet *)wmParseFunctions:(NSString*) strJson strMethod:(NSString*) strMethod strObjectID:(NSString*) strObjectID;
{
    
    //first create the soap envelope
    soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                   "<soap:Body>"
                   "<wmParseFunctions xmlns=\"MobileService\">"
                   "<strJson>%@</strJson>"
                   "<strMethod>%@</strMethod>"
                   "<strObjectID>%@</strObjectID>"
                   "</wmParseFunctions>"
                   "</soap:Body>"
                   "</soap:Envelope>",strJson, strMethod, strObjectID];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:_webServiceURL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:_Host forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"MobileService/wmParseFunctions" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    /*NSURLConnection *connection =
     [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
     
     if(connection)
     {
     webResponseData = [NSMutableData data] ;
     }
     else
     {
     NSLog(@"Connection is NULL");
     }*/
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse:nil error: nil];
    
    NSString *responseString;

    RRDataSet *datos;
    
    if (responseData == nil)
    {
        return datos;
        
    }
    else
    {
        
        responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];

        //No hay error por lo que parseamos el xml para obtener el resultado de la ejecucion del web service.
        RRWebServiceParser * parser = [[RRWebServiceParser alloc] initWithTokenResult:@"wmParseFunctionsResult"];
        
        [parser startParse:responseString];
        
        NSArray *JSONTokens = [parser.json componentsSeparatedByString:@"&SEP&"];
        NSString *strKeyValue;
        NSString *strChannels;
        NSDictionary *arr;
        NSArray *Channels;
        NSArray *DictArray;
        NSInteger *iCounter;
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];

        NSArray *temp = [JSONTokens.description componentsSeparatedByString:@"error:"];
            
        if(temp.count==1){
            for (NSString *JSONToken in JSONTokens) {
                NSData *data = [JSONToken dataUsingEncoding:NSUTF8StringEncoding];
                arr = [jsonParser objectWithData:data];
            }
            
            strKeyValue = @"";
            strChannels = @"";
            
            id result = [arr objectForKey:@"Response"];
            NSDictionary *DictArr = [result objectAtIndex:0];
            
            for (id key in DictArr) {
                if ([key isEqual:@"results"])
                {
                    DictArray = [[DictArr objectForKey:key] copy];
                }
            }
            
            
            if (DictArray.count > 1)
            {
                
                strKeyValue = [NSString stringWithFormat:@"%@[", strKeyValue];
                
                for (int i = 0; i < DictArray.count; i++) {
                    
                        DictArr = [DictArray objectAtIndex:i];
                    
                        if (i>0) {
                            strKeyValue = [NSString stringWithFormat:@"%@,", strKeyValue];
                        }
                    
                        strKeyValue = [NSString stringWithFormat:@"%@{", strKeyValue];
                    
                        iCounter = 0;
                    
                        for (id key in DictArr) {
                            
                            if (iCounter>0) {
                                strKeyValue = [NSString stringWithFormat:@"%@,", strKeyValue];
                            }
                            
                            if ([key isEqual:@"channels"])
                            {
                                Channels = [[DictArr objectForKey:key] copy];
                                for (NSString *item in Channels) {
                                    
                                    if (![strChannels isEqual:@""])
                                    {
                                        strChannels = [NSString stringWithFormat:@"%@,", strChannels];
                                    }
                                    
                                    strChannels = [NSString stringWithFormat:@"%@%@", strChannels, item.description];
                                    
                                }
                                
                                strKeyValue = [NSString stringWithFormat:@"%@\"%@\":\"%@\"", strKeyValue, key, strChannels];
                                
                            }else{
                                strKeyValue = [NSString stringWithFormat:@"%@\"%@\":\"%@\"", strKeyValue, key, [DictArr objectForKey:key]];
                            }
                            
                            iCounter = iCounter + 1;
                            
                        }
                    
                        strKeyValue = [NSString stringWithFormat:@"%@}", strKeyValue];
                    
                    }
                    
                    strKeyValue = [NSString stringWithFormat:@"%@]", strKeyValue];
                    
                
            }else{
            
            for (id key in DictArr) {
                
                if ([strKeyValue isEqual:@""])
                {
                    strKeyValue = [NSString stringWithFormat:@"%@[{", strKeyValue];
                }else{
                    strKeyValue = [NSString stringWithFormat:@"%@,", strKeyValue];
                }
                
                if ([key isEqual:@"channels"])
                {
                    Channels = [[DictArr objectForKey:key] copy];
                    for (NSString *item in Channels) {
                        
                        if (![strChannels isEqual:@""])
                        {
                            strChannels = [NSString stringWithFormat:@"%@,", strChannels];
                        }
                        
                        strChannels = [NSString stringWithFormat:@"%@%@", strChannels, item.description];
                        
                    }
                    
                    strKeyValue = [NSString stringWithFormat:@"%@\"%@\":\"%@\"", strKeyValue, key, strChannels];
                    
                }else{
                    strKeyValue = [NSString stringWithFormat:@"%@\"%@\":\"%@\"", strKeyValue, key, [DictArr objectForKey:key]];
                }
                
            }
            
                strKeyValue = [NSString stringWithFormat:@"%@}]", strKeyValue];
            }
            
            datos = [[RRDataSet alloc] initWithJSONString:strKeyValue];
        }else{
            datos = [[RRDataSet alloc] initWithJSONString:@"[{\"pkPeopleID\":\"\",\"sResult\":\"Error\"}]"];
        }

    }
    
    return datos;
    
}


@end
