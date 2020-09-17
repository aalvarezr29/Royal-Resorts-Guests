//
//  RRRestaurantService.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/19/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRDataSet.h"

@interface RRRestaurantService : NSObject
@property NSString *soapMessage;
@property NSString *currentElement;
@property NSMutableData *webResponseData;
@property NSString *strMsj;

-(RRRestaurantService*) initWithURL:(NSString*) webServiceURL Host:(NSString*) Host userNameMobile:(NSString *) userNameMobile passwordMobile:(NSString*) passwordMobile;

//-(RRDataSet *) spGetLoginBy:(NSString*) iType Param1:(NSString*) Param1 Param2:(NSString*) Param2 Param3:(NSString*) Param3 sNotificationToken:(NSString*) sNotificationToken;

-(RRDataSet *) spGetLoginBy:(NSString*) iType Param1:(NSString*) Param1 Param2:(NSString*) Param2 Param3:(NSString*) Param3;

-(RRDataSet *) spGetPeople:(NSString*) iType PeopleID:(NSString*) PeopleID;

-(RRDataSet *) spGetPinRecovery:(NSString*) iType Param1:(NSString*) Param1 Param2:(NSString*) Param2;

-(NSString *)wmSendEmailWebDocument:(NSString*) strEmailTo strLenguageCode:(NSString*) strLenguageCode Database:(NSString*) Database WebDocumentCode:(NSString*) WebDocumentCode WebDocumentValue1:(NSString*) WebDocumentValue1 WebDocumentValue2:(NSString*) WebDocumentValue2;

-(RRDataSet *) spGetGuestStay:(NSString*) iType PersonalID:(NSString*) PersonalID AppCode:(NSString*) AppCode DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetGuestAccount:(NSString*) iType AppCode:(NSString*) AppCode PersonalID:(NSString*) PersonalID StayInfoID:(NSString*) StayInfoID LastAccTrxID:(NSString*) LastAccTrxID DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetVoucherDetail:(NSString*) iType AppCode:(NSString*) AppCode PersonalID:(NSString*) PersonalID iValue:(NSString*) iValue DataBase:(NSString*) DataBase;

-(NSString *) wmPaymentCC:(NSString*) iType AppCode:(NSString*) AppCode DataBase:(NSString*) DataBase StayInfoID:(NSString*) StayInfoID PersonalID:(NSString*) PersonalID Amount:(NSString*) Amount strCc:(NSString*) strCc strExpDate:(NSString*) strExpDate strCvc2:(NSString*) strCvc2 intAccId:(NSString*) intAccId intTrxType:(NSString*) intTrxType strTrxDate:(NSString*) strTrxDate strReference:(NSString*) strReference strMail:(NSString*) strMail strLenguageCode:(NSString*) strLenguageCode PlaceID:(NSString*) PlaceID strForceMexicanCc:(NSString*) strForceMexicanCc strDocumentCode:(NSString*) strDocumentCode strFName:(NSString*) strFName strLname:(NSString*) strLname strCurrency:(NSString*) strCurrency;

-(RRDataSet *) spAddFdeskCheckOut:(NSString*) StayInfoID iResult:(NSString *)iResult sResult:(NSString *)sResult DataBase:(NSString*) DataBase;

-(NSString *) wmPosCheckOut:(NSString*) iType strStayInfoID:(NSString*) strStayInfoID strAccID:(NSString*) strAccID strArrivalDate:(NSString*) strArrivalDate strDepartureDate:(NSString*) strDepartureDate strBellBoydate:(NSString*) strBellBoydate strDataBase:(NSString*) strDataBase strBellBoyBag1:(NSString*) strBellBoyBag1;

-(RRDataSet *) spGetAppStayPeople:(NSString*) iType AppCode:(NSString *)AppCode PersonalID:(NSString *)PersonalID StayInfoID:(NSString *)StayInfoID DataBase:(NSString*) DataBase;

-(RRDataSet *) spSetAppStayPeople:(NSString*) iType AppCode:(NSString *)AppCode UserPersonalID:(NSString *)UserPersonalID StayInfoID:(NSString *)StayInfoID ID:(NSString *)ID FirstName:(NSString *)FirstName MiddleName:(NSString *)MiddleName LastName1:(NSString *)LastName1 LastName2:(NSString *)LastName2 EmailAddress:(NSString *)EmailAddress YearBirthday:(NSString *)YearBirthday ynPrimary:(NSString *)ynPrimary PhoneNo:(NSString *)PhoneNo dtExpectedArrival:(NSString*) dtExpectedArrival pkGuestAgeID:(NSString*) pkGuestAgeID DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetParseKeysWv:(NSString*) iType DataBase:(NSString*) DataBase;

-(RRDataSet *)wmParseFunctions:(NSString*) strJson strMethod:(NSString*) strMethod strObjectID:(NSString*) strObjectID DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetGuestAccPreAuthTrx:(NSString*) iType AppCode:(NSString *)AppCode PersonalID:(NSString *)PersonalID StayInfoID:(NSString *)StayInfoID DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetCmbCountry:(NSString*) DataBase;

-(NSString *) wmCallPostAuthMobile:(NSString*) iType strDataBase:(NSString*) strDataBase intAccTrxId:(NSString*) intAccTrxId dblAmount:(NSString*) dblAmount strTrxCode:(NSString*) strTrxCode strTrxTest:(NSString*) strTrxTest strMail:(NSString*) strMail strLenguageCode:(NSString*) strLenguageCode PersonalID:(NSString*) PersonalID strDocumentCode:(NSString*) strDocumentCode;

-(RRDataSet *) spGetMobileFollowUpVw:(NSString*) iType AppCode:(NSString *)AppCode peopleID:(NSString *)peopleID FollowUpId:(NSString *)FollowUpId DataBase:(NSString*) DataBase sLanguage:(NSString*) sLanguage;

-(NSString *) wmCallAddFollowUp:(NSString*) strDataBase unitcode:(NSString*) unitcode stayinfoID:(NSString*) stayinfoID iPeopleID:(NSString*) iPeopleID fTypeID:(NSString*) fTypeID reqShort:(NSString*) reqShort reqlong:(NSString*) reqlong Solution:(NSString*) Solution expect:(NSString*) expect finish:(NSString*) finish statusID:(NSString*) statusID strLenguageCode:(NSString*) strLenguageCode strDocumentCode:(NSString*) strDocumentCode strPeopleEmail:(NSString*) strPeopleEmail;

-(NSString *) wmGetCCExchangeVwPCI:(NSString*) strDataBase strCc:(NSString*) strCc strAccID:(NSString*) strAccID;

-(RRDataSet *) spGetRestaurantDefault:(NSString*) iType PropertyID:(NSString *)PropertyID TypeCode:(NSString *)TypeCode StayInfoID:(NSString *)StayInfoID DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetRestaurantAvailability:(NSString*) iType RestaurantCode:(NSString *)RestaurantCode dateTimeStart:(NSString*) dateTimeStart PeopleNo:(NSString *)PeopleNo Children:(NSString *)Children DataBase:(NSString*) DataBase;

-(RRDataSet *) spAddRestReservationWeb:(NSString*) iType FirstName:(NSString *)FirstName LastName:(NSString*) LastName Date:(NSString *)Date Time:(NSString *)Time RestaurantCode:(NSString *)RestaurantCode NumAdult:(NSString *)NumAdult NumChildren:(NSString *)NumChildren ynRRGuest:(NSString *)ynRRGuest PropertyCode:(NSString *)PropertyCode HotelName:(NSString *)HotelName RoomNum:(NSString *)RoomNum ynRefine:(NSString *)ynRefine Email:(NSString *)Email Note:(NSString *)Note SourceCode:(NSString *)SourceCode ZoneCode:(NSString *)ZoneCode PRCode:(NSString *)PRCode DataBase:(NSString*) DataBase;

-(RRDataSet *) spSetAppPeoplePushToken:(NSString*) iType PeopleID:(NSString*) PeopleID Token:(NSString*) Token osCode:(NSString*) osCode AppCode:(NSString*) AppCode DataBase:(NSString*) DataBase;

-(RRDataSet *) spGetAppPeopleChannelVw:(NSString*) iType AppCode:(NSString*) AppCode PeopleID:(NSString*) PeopleID DataBase:(NSString*) DataBase;

-(RRDataSet *) spSetAppPeopleChannel:(NSString*) iType AppCode:(NSString*) AppCode PeopleID:(NSString*) PeopleID pkChannelID:(NSString*) pkChannelID DataBase:(NSString*) DataBase;

-(RRDataSet *) spAddFdeskAccTrx:(NSString*) DataBase iAccid:(NSString*) iAccid sTrxTypeCode:(NSString *)sTrxTypeCode iKeycardid:(NSString *)iKeycardid sPlacecode:(NSString *)sPlacecode sDocument:(NSString *)sDocument sRemark:(NSString *)sRemark dTrxdate:(NSString *)dTrxdate mSubTotal:(NSString *)mSubTotal mTax1:(NSString *)mTax1 mTax2:(NSString *)mTax2 mTax3:(NSString *)mTax3 mSubtotalExento:(NSString *)mSubtotalExento mSubtotalBaseCero:(NSString *)mSubtotalBaseCero mTip1:(NSString*) mTip1 mTip2:(NSString*) mTip2 mTotal:(NSString*) mTotal sFolioType:(NSString*) sFolioType iAccFolioID:(NSString*) iAccFolioID iCompleted:(NSString*) iCompleted sMsg:(NSString*) sMsg sUserLogin:(NSString*) sUserLogin sOperation:(NSString*) sOperation ynSkipConsumptionLimit:(NSString*) ynSkipConsumptionLimit;

-(RRDataSet *) wmGetRewardBalance:(NSString*) strDataBase strPersonalID:(NSString*) strPersonalID ynDecryCred:(NSString*) ynDecryCred;

-(RRDataSet *) wmApplyRewardCharge:(NSString*) strDataBase strAccId:(NSString*) strAccId strTypeCode:(NSString*) strTypeCode iPersonaId:(NSString*) iPersonaId iKeycardID:(NSString*) iKeycardID strPlaceCode:(NSString*) strPlaceCode mAmount:(NSString*) mAmount iStoreId:(NSString*) iStoreId sCurrencyCode:(NSString*) sCurrencyCode sDocument:(NSString*) sDocument sRemark:(NSString*) sRemark dTrxDate:(NSString*) dTrxDate sUserLogin:(NSString*) sUserLogin;

-(RRDataSet *) wmGetCalagoHoteles:(NSString*) sClientToken sAppToken:(NSString*) sAppToken sleguage:(NSString*) sleguage iModo:(NSString*) iModo strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5;

-(RRDataSet *) wmGetCatalogItemsVtm:(NSString*) sLanguageCode sItemCode:(NSString*) sItemCode sAttributeCodes:(NSString*) sAttributeCodes iTransferTypeID:(NSString*) iTransferTypeID sItemTypeCodes:(NSString*) sItemTypeCodes sHotelArrivalCode:(NSString*) sHotelArrivalCode sHotelDeparturCode:(NSString*) sHotelDeparturCode iNumPax:(NSString*) iNumPax sClientToken:(NSString*) sClientToken sAppToken:(NSString*) sAppToken strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5;

-(RRDataSet *) wmGetFlightVtmTrans:(NSString*) iModo iOperator:(NSString*) iOperator sFlightTypeCode:(NSString*) sFlightTypeCode strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5;

-(RRDataSet *) wmAddReservation:(NSString*) sResTypeCode sLanguageCode:(NSString*) sLanguageCode sSourceCode:(NSString*) sSourceCode iPeopleFromCDRID:(NSString*) iPeopleFromCDRID sFname:(NSString*) sFname sLname1:(NSString*) sLname1 sEmailAddress:(NSString*) sEmailAddress sTerminalCode:(NSString*) sTerminalCode sWorkStationCode:(NSString*) sWorkStationCode sUserLogin:(NSString*) sUserLogin iApplicationClient:(NSString*) iApplicationClient IItemVariantID:(NSString*) IItemVariantID iPax:(NSString*) iPax sArrivalHotelCode:(NSString*) sArrivalHotelCode sDepartureHotelCode:(NSString*) sDepartureHotelCode SPaymentTypeCode:(NSString*) SPaymentTypeCode sRoom:(NSString*) sRoom SConfirmationCode:(NSString*) SConfirmationCode dtArrivalDate:(NSString*) dtArrivalDate sArrivalFlightCode:(NSString*) sArrivalFlightCode sArrivalComment:(NSString*) sArrivalComment dtDepartureDate:(NSString*) dtDepartureDate sDepartureFlightCode:(NSString*) sDepartureFlightCode ynArrival:(NSString*) ynArrival iArrivalHotelID:(NSString*) iArrivalHotelID iDepartureHotelID:(NSString*) iDepartureHotelID ynIncludeDetail:(NSString*) ynIncludeDetail SLimitDate:(NSString*) SLimitDate DtDateIn:(NSString*) DtDateIn DtDateOut:(NSString*) DtDateOut STransferTypeCode:(NSString*) STransferTypeCode SWebDocumentCode:(NSString*) SWebDocumentCode SOrigin:(NSString*) SOrigin SDestiny:(NSString*) SDestiny strToken1:(NSString*) strToken1 strToken2:(NSString*) strToken2 strToken3:(NSString*) strToken3 strToken4:(NSString*) strToken4 strToken5:(NSString*) strToken5;

-(RRDataSet *) spGetPreRegReservation:(NSString*) iType iPeopleID:(NSString*) iPeopleID ConfirmationCode:(NSString*) ConfirmationCode Fname:(NSString*) Fname LName:(NSString*) LName CheckinDt:(NSString*) CheckinDt ResortCode:(NSString*) ResortCode DataBase:(NSString*) DataBase;

@end

