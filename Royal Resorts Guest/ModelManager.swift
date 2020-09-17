//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    //var DataStays: [String:String]!
    
    class var instance: ModelManager {
        sharedInstance.database = FMDatabase(path: Util.getPath("GuestStay.sqlite"))
        var path = Util.getPath("GuestStay.sqlite")
        print(Util.getPath("GuestStay.sqlite"))
        return sharedInstance
    }
    
    func addDatosLogin(_ tblLogin: Dictionary<String, String>) -> Bool {
        sharedInstance.database!.open()
        
        var Email: String = "", PIN: String = "", PersonalID: String = "", Gender: String = "", Lenguage: String = "", FullName: String = "", FirstName: String = "", LastName: String = "", Field1: String = "", Field2: String = "", Field3: String = "", Field4: String = "", Field5: String = "", LastStayUpdate: String = "", PeopleType: String = ""
        
        Email = String(tblLogin["Email"]!)
        PIN = String(tblLogin["PIN"]!)
        PersonalID = String(tblLogin["PersonalID"]!)
        Gender = String(tblLogin["Gender"]!)
        Lenguage = String(tblLogin["Lenguage"]!)
        FullName = String(tblLogin["FullName"]!)
        FirstName = String(tblLogin["FirstName"]!)
        LastName = String(tblLogin["LastName"]!)
        Field1 = String(tblLogin["Field1"]!)
        Field2 = String(tblLogin["Field2"]!)
        Field3 = String(tblLogin["Field3"]!)
        Field4 = String(tblLogin["Field4"]!)
        Field5 = String(tblLogin["Field5"]!)
        LastStayUpdate = String(tblLogin["LastStayUpdate"]!)
        PeopleType = String(tblLogin["PeopleType"]!)
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO tblLogin (Email, PIN, PersonalID, Gender, Lenguage, FullName, FirstName, LastName, Field1, Field2, Field3, Field4, Field5, LastStayUpdate, PeopleType) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [Email, PIN, PersonalID, Gender, Lenguage, FullName, FirstName, LastName,Field1, Field2, Field3, Field4, Field5, LastStayUpdate, PeopleType])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func addStayInfo(_ tblStay: Dictionary<String, String>) {
        sharedInstance.database!.open()
        var StayInfoID: String = "", DatabaseName: String = "", PropertyCode: String = "", PropertyName: String = "", UnitCode: String = "", StatusCode: String = "", StatusDesc: String = "", ArrivalDate: String = "", DepartureDate: String = "", PrimaryPeopleID: String = "", OrderNo: String = "", Intv: String = "", IntvYear: String = "", fkAccID: String = "", fkTrxTypeCCID: String = "", AccCode: String = "", USDExchange: String = "", UnitID: String = "", FloorPlanDesc: String = "", UnitViewDesc: String = "", ynPostCheckout: String = "", LastAccountUpdate: String = "", PrimAgeCFG: String = "", fkPlaceID: String = "", DepartureDateCheckOut: String = "", ConfirmationCode: String = "", fkCurrencyID : String = ""
        
        StayInfoID = tblStay["StayInfoID"]!
        DatabaseName = tblStay["DatabaseName"]!
        PropertyCode = tblStay["PropertyCode"]!
        PropertyName = tblStay["PropertyName"]!
        UnitCode = tblStay["UnitCode"]!
        StatusCode = tblStay["StatusCode"]!
        StatusDesc = tblStay["StatusDesc"]!
        ArrivalDate = tblStay["ArrivalDate"]!
        DepartureDate = tblStay["DepartureDate"]!
        PrimaryPeopleID = tblStay["PrimaryPeopleID"]!
        OrderNo = tblStay["OrderNo"]!
        Intv = tblStay["Intv"]!
        IntvYear = tblStay["IntvYear"]!
        fkAccID = tblStay["fkAccID"]!
        fkTrxTypeCCID = tblStay["fkTrxTypeCCID"]!
        AccCode = tblStay["AccCode"]!
        USDExchange = tblStay["USDExchange"]!
        UnitID = tblStay["UnitID"]!
        FloorPlanDesc = tblStay["FloorPlanDesc"]!
        UnitViewDesc = tblStay["UnitViewDesc"]!
        ynPostCheckout = "0"
        LastAccountUpdate = ""
        PrimAgeCFG = tblStay["PrimAgeCFG"]!
        fkPlaceID = tblStay["fkPlaceID"]!
        DepartureDateCheckOut = tblStay["DepartureDateCheckOut"]!
        ConfirmationCode = tblStay["ConfirmationCode"]!
        fkCurrencyID = tblStay["fkCurrencyID"]!
        
        sharedInstance.database!.executeUpdate("INSERT INTO tblStay (StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, ynPostCheckout, LastAccountUpdate, PrimAgeCFG, fkPlaceID, DepartureDateCheckOut, ConfirmationCode, fkCurrencyID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeCCID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, ynPostCheckout, LastAccountUpdate, PrimAgeCFG, fkPlaceID, DepartureDateCheckOut, ConfirmationCode, fkCurrencyID])
        
        sharedInstance.database!.close()
    }
    
    func addAccountPeople(_ AccountPeople: Dictionary<String, String>) {
        sharedInstance.database!.open()
        
        var StayInfoID: String = "", DatabaseName: String = "", PersonID: String = "", FullName: String = "", FirstName: String = "", LastName: String = "", PeopleFDeskID: String = "", YearBirthDay: String = "", ynPrimary: String = "", MiddleName: String = "", SecondLName: String = "", EmailAddress: String = "", ynPreRegisterAvailable: String = "", NumOfPeopleForStay: String = "", Age: String = "", pkPreRegisterID: String = "", PreRegisterTypeDesc: String = "", GuestType: String = ""
        
        StayInfoID = String(AccountPeople["StayInfoID"]!)
        DatabaseName = String(AccountPeople["DatabaseName"]!)
        PersonID = String(AccountPeople["PersonID"]!)
        FullName = String(AccountPeople["FullName"]!)
        FirstName = String(AccountPeople["FirstName"]!)
        MiddleName = String(AccountPeople["MiddleName"]!)
        LastName = String(AccountPeople["LastName"]!)
        SecondLName = String(AccountPeople["SecondLName"]!)
        EmailAddress = String(AccountPeople["EmailAddress"]!)
        PeopleFDeskID = String(AccountPeople["PeopleFDeskID"]!)
        YearBirthDay = String(AccountPeople["YearBirthDay"]!)
        ynPrimary = String(AccountPeople["ynPrimary"]!)
        ynPreRegisterAvailable = String(AccountPeople["ynPreRegisterAvailable"]!)
        NumOfPeopleForStay = String(AccountPeople["NumOfPeopleForStay"]!)
        Age = String(AccountPeople["Age"]!)
        pkPreRegisterID = String(AccountPeople["pkPreRegisterID"]!)
        PreRegisterTypeDesc = String(AccountPeople["PreRegisterTypeDesc"]!)
        GuestType = String(AccountPeople["GuestType"]!)
        
        sharedInstance.database!.executeUpdate("INSERT INTO tblPerson (StayInfoID,DatabaseName,PersonID,FullName,FirstName, MiddleName, LastName, SecondLName, EmailAddress, PeopleFDeskID, YearBirthDay, ynPrimary, ynPreRegisterAvailable, NumOfPeopleForStay, Age, pkPreRegisterID, PreRegisterTypeDesc, GuestType) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [StayInfoID, DatabaseName, PersonID, FullName, FirstName, MiddleName, LastName, SecondLName, EmailAddress, PeopleFDeskID, YearBirthDay, ynPrimary, ynPreRegisterAvailable, NumOfPeopleForStay, Age, pkPreRegisterID, PreRegisterTypeDesc, GuestType])
        
        sharedInstance.database!.close()

    }
    
    func addAccountInfo(_ AccountInfo: Dictionary<String, String>) {
        sharedInstance.database!.open()
        var StayInfoID: String = "", DatabaseName: String = "", fkAccTrxID: String = "", Voucher: String = "", PlaceDesc: String = "", Amount: String = "", TrxDate: String = "", PersonID: String = "", SubTotal: String = "", Tips: String = "", Cashier: String = "", TrxTypeCode: String = "", TrxTime: String = "", PeopleFDeskID = ""
        
        StayInfoID = String(AccountInfo["StayInfoID"]!)
        DatabaseName = String(AccountInfo["DatabaseName"]!)
        fkAccTrxID = String(AccountInfo["fkAccTrxID"]!)
        Voucher = String(AccountInfo["Voucher"]!)
        PlaceDesc = String(AccountInfo["PlaceDesc"]!)
        Amount = String(AccountInfo["Amount"]!)
        TrxDate = String(AccountInfo["TrxDate"]!)
        PersonID = String(AccountInfo["PersonID"]!)
        SubTotal = String(AccountInfo["SubTotal"]!)
        Tips = String(AccountInfo["Tips"]!)
        Cashier = String(AccountInfo["Cashier"]!)
        TrxTypeCode = String(AccountInfo["TrxTypeCode"]!)
        TrxTime = String(AccountInfo["TrxTime"]!)
        PeopleFDeskID = String(AccountInfo["PeopleFDeskID"]!)
        
        /*var strQuery: String=""
        var ynExist: Bool=false
        
        var Index: Int = 0

        
        strQuery = "SELECT fkAccTrxID FROM tblAccount where fkAccTrxID = ?"
        
        var resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsInArray: [fkAccTrxID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Index = 1
                
            }
        }
        
        if Index == 1{
            ynExist = true
        }else{
            ynExist = false
        }
        
        if !ynExist{*/
        sharedInstance.database!.executeUpdate("INSERT INTO tblAccount (StayInfoID, DatabaseName, fkAccTrxID, Voucher, PlaceDesc, Amount, TrxDate, PersonID, SubTotal, Tips, Cashier, TrxTypeCode, TrxTime, PeopleFDeskID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [StayInfoID, DatabaseName, fkAccTrxID, Voucher, PlaceDesc, Amount, TrxDate, PersonID, SubTotal, Tips, Cashier, TrxTypeCode, TrxTime, PeopleFDeskID])
        //}
        sharedInstance.database!.close()
    }
    
    func addTrxDetail(_ AccountInfo: Dictionary<String, String>) -> Bool {
        sharedInstance.database!.open()
        
        var fkAccTrxID: String = "", ItemCode: String = "", Quantity: String = "", ItemDesc: String = "", Total: String = ""
        
        fkAccTrxID = String(AccountInfo["fkAccTrxID"]!)
        ItemCode = String(AccountInfo["ItemCode"]!)
        Quantity = String(AccountInfo["Quantity"]!)
        ItemDesc = String(AccountInfo["ItemDesc"]!)
        Total = String(AccountInfo["Total"]!)
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO tblAccountDetail (fkAccTrxID, ItemCode, Quantity, ItemDesc, Total) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [fkAccTrxID, ItemCode, Quantity, ItemDesc, Total])
        sharedInstance.database!.close()
        return isInserted
    }


    func updateLastStayDate(_ PeopleID: String){
        sharedInstance.database!.open()
        let todaysDate:Date = Date()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let DateInFormat:String = dateFormatter.string(from: todaysDate)
        sharedInstance.database!.executeUpdate("UPDATE tblLogin SET LastStayUpdate=? WHERE PersonalID=?", withArgumentsIn: [DateInFormat,PeopleID])
        sharedInstance.database!.close()
    }
    
    func updateStayInfo(_ tblStay: Dictionary<String, String>) -> Bool {
        sharedInstance.database!.open()
        var StayInfoID: String = "", DatabaseName: String = "", PropertyCode: String = "", PropertyName: String = "", UnitCode: String = "", StatusCode: String = "", StatusDesc: String = "", ArrivalDate: String = "", DepartureDate: String = "", PrimaryPeopleID: String = "", OrderNo: String = "", Intv: String = "", IntvYear: String = "", fkAccID: String = "", fkTrxTypeCCID: String = "", AccCode: String = "", USDExchange: String = "", UnitID: String = "", FloorPlanDesc: String = "", UnitViewDesc: String = ""
        
        StayInfoID = tblStay["StayInfoID"]!
        DatabaseName = tblStay["DatabaseName"]!
        PropertyCode = tblStay["PropertyCode"]!
        PropertyName = tblStay["PropertyName"]!
        UnitCode = tblStay["UnitCode"]!
        StatusCode = tblStay["StatusCode"]!
        StatusDesc = tblStay["StatusDesc"]!
        ArrivalDate = tblStay["ArrivalDate"]!
        DepartureDate = tblStay["DepartureDate"]!
        PrimaryPeopleID = tblStay["PrimaryPeopleID"]!
        OrderNo = tblStay["OrderNo"]!
        Intv = tblStay["Intv"]!
        IntvYear = tblStay["IntvYear"]!
        fkAccID = tblStay["fkAccID"]!
        fkTrxTypeCCID = tblStay["fkTrxTypeCCID"]!
        AccCode = tblStay["AccCode"]!
        USDExchange = tblStay["USDExchange"]!
        UnitID = tblStay["UnitID"]!
        FloorPlanDesc = tblStay["FloorPlanDesc"]!
        UnitViewDesc = tblStay["UnitViewDesc"]!


        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE tblStay SET StayInfoID = ?, DatabaseName = ?, PropertyCode = ?, UnitCode = ?, StatusCode = ?, StatusDesc = ?, ArrivalDate = ?, DepartureDate = ?, PropertyName = ?, PrimaryPeopleID = ?, OrderNo = ?, Intv= ?, IntvYear = ?, fkAccID = ?, fkTrxTypeID = ?, AccCode = ?, USDExchange = ?, UnitID = ?, FloorPlanDesc = ?, UnitViewDesc = ? WHERE StayInfoID=?", withArgumentsIn: [StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeCCID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, StayInfoID])
        
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func updateCheckOut(_ StayInfoID: String){
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("UPDATE tblStay SET ynPostCheckout=1 WHERE StayInfoID=?", withArgumentsIn: [StayInfoID])
        sharedInstance.database!.close()
    }
    
    func updateAccountInfo(_ StayInfoID: String) {
        sharedInstance.database!.open()
        let todaysDate:Date = Date()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let DateInFormat:String = dateFormatter.string(from: todaysDate)
        sharedInstance.database!.executeUpdate("UPDATE tblStay SET LastAccountUpdate=? WHERE StayInfoID=?", withArgumentsIn: [DateInFormat,StayInfoID])
        sharedInstance.database!.close()

    }
    func updateLogIn(_ PeopleID: String, PIN: String) -> Bool {
        sharedInstance.database!.open()
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE tblLogin SET PIN=? WHERE PersonalID=?", withArgumentsIn: [PIN, PeopleID])
        sharedInstance.database!.close()
        return isUpdated
    }
    func updateLogOut(_ PeopleID: String) -> Bool {
        sharedInstance.database!.open()

        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE tblLogin SET PIN='-1', LastStayUpdate = '' WHERE PersonalID=?", withArgumentsIn: [PeopleID])
        sharedInstance.database!.close()
        return isUpdated
    }

    func updateUSDExchange(_ StayInfoID: String, USDExchange: String) {
        sharedInstance.database!.open()
        
        sharedInstance.database!.executeUpdate("UPDATE tblStay SET USDExchange = ? WHERE StayInfoID=?", withArgumentsIn: [USDExchange,StayInfoID])
        sharedInstance.database!.close()
        
    }
    func deleteLogintData(){
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tblLogin", withArgumentsIn: [])
        sharedInstance.database!.close()
    }
    
    func deleteStayInfoData(){
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tblStay", withArgumentsIn: [])
        sharedInstance.database!.close()
    }
    
    func deleteAccountData(){
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tblAccount", withArgumentsIn: [])
        sharedInstance.database!.close()
    }
    
    func deletePeopleAccount(_ StayInfoID: String){
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tblPerson WHERE StayInfoID=?", withArgumentsIn: [StayInfoID])
        sharedInstance.database!.close()
    }


    func deleteAllPeopleAccount(){
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tblPerson", withArgumentsIn: [])
        sharedInstance.database!.close()
    }
    func LogOUT(){
        deleteLogintData()
        deleteStayInfoData()
        deleteAccountData()
        deleteAllPeopleAccount()
    }
    func getLoginData(_ PeopleID: String) -> Dictionary<String, String> {
        var tblLogin: Dictionary<String, String>
        var strQuery: String = ""

        sharedInstance.database!.open()
        
        if (PeopleID==""){
            strQuery = "SELECT * FROM tblLogin WHERE PIN > 0"
        }else{
            strQuery = "SELECT * FROM tblLogin WHERE PersonalID = ?"
        }
        
        tblLogin = [:]
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [PeopleID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                tblLogin["Email"] = resultSet.string(forColumn: "Email")
                tblLogin["PIN"] = resultSet.string(forColumn: "PIN")
                tblLogin["PersonalID"] = resultSet.string(forColumn: "PersonalID")
                tblLogin["Gender"] = resultSet.string(forColumn: "Gender")
                tblLogin["Lenguage"] = resultSet.string(forColumn: "Lenguage")
                tblLogin["FullName"] = resultSet.string(forColumn: "FullName")
                tblLogin["FirstName"] = resultSet.string(forColumn: "FirstName")
                tblLogin["LastName"] = resultSet.string(forColumn: "LastName")
                tblLogin["Field1"] = resultSet.string(forColumn: "Field1")
                tblLogin["Field2"] = resultSet.string(forColumn: "Field2")
                tblLogin["Field3"] = resultSet.string(forColumn: "Field3")
                tblLogin["Field4"] = resultSet.string(forColumn: "Field4")
                tblLogin["Field5"] = resultSet.string(forColumn: "Field5")
                tblLogin["LastStayUpdate"] = resultSet.string(forColumn: "LastStayUpdate")
                tblLogin["PeopleType"] = resultSet.string(forColumn: "PeopleType")
                tblLogin["Address"] = resultSet.string(forColumn: "Address")!
                tblLogin["City"] = resultSet.string(forColumn: "City")!
                tblLogin["ZipCode"] = resultSet.string(forColumn: "ZipCode")!
                tblLogin["State"] = resultSet.string(forColumn: "State")!
                tblLogin["Country"] = resultSet.string(forColumn: "Country")!
                tblLogin["ISOCode"] = resultSet.string(forColumn: "ISOCode")!
                tblLogin["Phone"] = resultSet.string(forColumn: "Phone")!
                tblLogin["URLcxPay"] = resultSet.string(forColumn: "URLcxPay")!
                tblLogin["TokenCLBRPay"] = resultSet.string(forColumn: "TokenCLBRPay")!
                
            }
        }
        
        sharedInstance.database!.close()
        return tblLogin
    }

    func getStayGroup(_ resultCount: Int32, PrimaryPeopleID: String) -> [Dictionary<String, String>] {
        var Stays: [Dictionary<String, String>]
        var DataStays = [String:String]()
        
        var Index: Int = 0
        sharedInstance.database!.open()

        //var resultCount: Int32 = sharedInstance.database!.intForQuery("SELECT COUNT(*) FROM tblStay","")
        
        Stays = []
        
        for _ in 0...resultCount-1 {
            Stays.append([:])
        }
        
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblStay", withArgumentsIn: [])
        
        if (resultSet != nil) {
            while resultSet.next() {

                DataStays["StayInfoID"] = String(describing: resultSet.string(forColumn: "StayInfoID"))
                DataStays["DatabaseName"] = String(describing: resultSet.string(forColumn: "DatabaseName"))
                DataStays["PropertyCode"] = String(describing: resultSet.string(forColumn: "PropertyCode"))
                DataStays["PropertyName"] = String(describing: resultSet.string(forColumn: "PropertyName"))
                DataStays["UnitCode"] = String(describing: resultSet.string(forColumn: "UnitCode"))
                DataStays["StatusCode"] = String(describing: resultSet.string(forColumn: "StatusCode"))
                DataStays["StatusDesc"] = String(describing: resultSet.string(forColumn: "StatusDesc"))
                DataStays["ArrivalDate"] = String(describing: resultSet.string(forColumn: "ArrivalDate"))
                DataStays["DepartureDate"] = String(describing: resultSet.string(forColumn: "DepartureDate"))
                DataStays["PrimaryPeopleID"] = String(describing: resultSet.string(forColumn: "PrimaryPeopleID"))
                DataStays["OrderNo"] = String(describing: resultSet.string(forColumn: "OrderNo"))
                DataStays["PrimAgeCFG"] = String(describing: resultSet.string(forColumn: "PrimAgeCFG"))
                DataStays["fkPlaceID"] = String(describing: resultSet.string(forColumn: "fkPlaceID"))
                DataStays["DepartureDateCheckOut"] = String(describing: resultSet.string(forColumn: "DepartureDateCheckOut"))
                DataStays["ConfirmationCode"] = String(describing: resultSet.string(forColumn: "ConfirmationCode"))
                DataStays["fkCurrencyID"] = String(describing: resultSet.string(forColumn: "fkCurrencyID"))
                Stays[Index] = DataStays
                
                Index = Index + 1
            }
        }

        sharedInstance.database!.close()
        return Stays
    }
    func getStayGroupFollow(_ resultCount: Int32, PrimaryPeopleID: String) -> [Dictionary<String, String>] {
        var Stays: [Dictionary<String, String>]
        var DataStays = [String:String]()
        
        var Index: Int = 0
        sharedInstance.database!.open()
        
        //var resultCount: Int32 = sharedInstance.database!.intForQuery("SELECT COUNT(*) FROM tblStay","")
        
        Stays = []
        
        for _ in 0...resultCount-1 {
            Stays.append([:])
        }
        
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblStay WHERE OrderNo IN(1,2)", withArgumentsIn: [])
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                DataStays["StayInfoID"] = String(describing: resultSet.string(forColumn: "StayInfoID"))
                DataStays["DatabaseName"] = String(describing: resultSet.string(forColumn: "DatabaseName"))
                DataStays["PropertyCode"] = String(describing: resultSet.string(forColumn: "PropertyCode"))
                DataStays["PropertyName"] = String(describing: resultSet.string(forColumn: "PropertyName"))
                DataStays["UnitCode"] = String(describing: resultSet.string(forColumn: "UnitCode"))
                DataStays["StatusCode"] = String(describing: resultSet.string(forColumn: "StatusCode"))
                DataStays["StatusDesc"] = String(describing: resultSet.string(forColumn: "StatusDesc"))
                DataStays["ArrivalDate"] = String(describing: resultSet.string(forColumn: "ArrivalDate"))
                DataStays["DepartureDate"] = String(describing: resultSet.string(forColumn: "DepartureDate"))
                DataStays["PrimaryPeopleID"] = String(describing: resultSet.string(forColumn: "PrimaryPeopleID"))
                DataStays["OrderNo"] = String(describing: resultSet.string(forColumn: "OrderNo"))
                DataStays["PrimAgeCFG"] = String(describing: resultSet.string(forColumn: "PrimAgeCFG"))
                DataStays["fkPlaceID"] = String(describing: resultSet.string(forColumn: "fkPlaceID"))
                DataStays["DepartureDateCheckOut"] = String(describing: resultSet.string(forColumn: "DepartureDateCheckOut"))
                DataStays["ConfirmationCode"] = String(describing: resultSet.string(forColumn: "ConfirmationCode"))
                DataStays["fkCurrencyID"] = String(describing: resultSet.string(forColumn: "fkCurrencyID"))
                Stays[Index] = DataStays
                
                Index = Index + 1
            }
        }
        
        sharedInstance.database!.close()
        return Stays
    }
    func getStayInfo(_ StayInfoID: String) -> Dictionary<String, String> {
        var Stays: Dictionary<String, String>

        sharedInstance.database!.open()
        
        Stays = [:]

        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblStay WHERE StayInfoID = ?", withArgumentsIn: [StayInfoID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Stays["StayInfoID"] = resultSet.string(forColumn: "StayInfoID")
                Stays["DatabaseName"] = resultSet.string(forColumn: "DatabaseName")
                Stays["PropertyCode"] = resultSet.string(forColumn: "PropertyCode")
                Stays["PropertyName"] = resultSet.string(forColumn: "PropertyName")
                Stays["UnitCode"] = resultSet.string(forColumn: "UnitCode")
                Stays["StatusCode"] = resultSet.string(forColumn: "StatusCode")
                Stays["StatusDesc"] = resultSet.string(forColumn: "StatusDesc")
                Stays["ArrivalDate"] = resultSet.string(forColumn: "ArrivalDate")
                Stays["DepartureDate"] = resultSet.string(forColumn: "DepartureDate")
                Stays["PrimaryPeopleID"] = resultSet.string(forColumn: "PrimaryPeopleID")
                Stays["OrderNo"] = resultSet.string(forColumn: "OrderNo")
                Stays["Intv"] = resultSet.string(forColumn: "Intv")
                Stays["IntvYear"] = resultSet.string(forColumn: "IntvYear")
                Stays["fkAccID"] = resultSet.string(forColumn: "fkAccID")
                Stays["fkTrxTypeID"] = resultSet.string(forColumn: "fkTrxTypeID")
                Stays["AccCode"] = resultSet.string(forColumn: "AccCode")
                Stays["USDExchange"] = resultSet.string(forColumn: "USDExchange")
                Stays["UnitID"] = resultSet.string(forColumn: "UnitID")
                Stays["FloorPlanDesc"] = resultSet.string(forColumn: "FloorPlanDesc")
                Stays["UnitViewDesc"] = resultSet.string(forColumn: "UnitViewDesc")
                Stays["ynPostCheckout"] = resultSet.string(forColumn: "ynPostCheckout")
                Stays["LastAccountUpdate"] = resultSet.string(forColumn: "LastAccountUpdate")
                Stays["PrimAgeCFG"] = resultSet.string(forColumn: "PrimAgeCFG")
                Stays["fkPlaceID"] = resultSet.string(forColumn: "fkPlaceID")
                Stays["DepartureDateCheckOut"] = resultSet.string(forColumn: "DepartureDateCheckOut")
                Stays["ConfirmationCode"] = resultSet.string(forColumn: "ConfirmationCode")
                Stays["fkCurrencyID"] = String(describing: resultSet.string(forColumn: "fkCurrencyID"))
            }
        }
        
        sharedInstance.database!.close()
        return Stays
    }
    
    func getStatusStayInfo(_ StayInfo: [Dictionary<String, String>], CountStays: Int32) -> [[Dictionary<String, String>]] {
        var Status: [String]
        var StaysStatus: [[Dictionary<String, String>]]

        var Index: Int = 0
        var contStatus: Int = 0
        var CountStatusTot: Int32 = 0
        
        CountStatusTot = ModelManager.instance.getCount("SELECT COUNT(*) FROM (SELECT OrderNo FROM tblStay GROUP BY OrderNo)", strArgs: "")

        sharedInstance.database!.open()

        StaysStatus = []
        Status = [""]

        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT count(*) as CountStatus,OrderNo FROM tblStay GROUP BY OrderNo ORDER BY OrderNo DESC", withArgumentsIn: [])
        if (resultSet != nil) {
            while resultSet.next() {

                if (Index==0){
                    Status[0] = resultSet.string(forColumn: "OrderNo")!
                    contStatus = Int(resultSet.int(forColumn: "CountStatus"))
                    StaysStatus.append([])
                    for _ in 0...contStatus-1 {
                        StaysStatus[0].append([:])
                    }

                }else{
                    Status.append(resultSet.string(forColumn: "OrderNo")!)
                    contStatus = Int(resultSet.int(forColumn: "CountStatus"))
                    StaysStatus.append([])
                    for _ in 0...contStatus-1 {
                        StaysStatus[Index].append([:])
                    }

                }
                Index = Index + 1
            }
        }
        
        let xCountStatus = Int(CountStatusTot)
        let xCountStays = Int(CountStays)
        var sCount: Int = 0

        for xIndex in 0...xCountStatus-1 {
            sCount = 0
            for yIndex in 0...xCountStays-1 {
                if (Status[xIndex]==StayInfo[yIndex]["OrderNo"]){
                    StaysStatus[xIndex][sCount] = StayInfo[yIndex]
                    sCount = sCount + 1
                }
                
            }
            
        }
        
        sharedInstance.database!.close()

        return StaysStatus
    }
    func getStatusStayInfoFollow(_ StayInfo: [Dictionary<String, String>], CountStays: Int32) -> [[Dictionary<String, String>]] {
        var Status: [String]
        var StaysStatus: [[Dictionary<String, String>]]
        
        var Index: Int = 0
        var contStatus: Int = 0
        var CountStatusTot: Int32 = 0
        
        CountStatusTot = ModelManager.instance.getCount("SELECT COUNT(*) FROM (SELECT OrderNo FROM tblStay WHERE OrderNo IN(1,2) GROUP BY OrderNo)", strArgs: "")
        
        sharedInstance.database!.open()
        
        StaysStatus = []
        Status = [""]
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT count(*) as CountStatus,OrderNo FROM tblStay WHERE OrderNo IN(1,2) GROUP BY OrderNo ORDER BY OrderNo DESC", withArgumentsIn: [])
        if (resultSet != nil) {
            while resultSet.next() {
                
                if (Index==0){
                    Status[0] = resultSet.string(forColumn: "OrderNo")!
                    contStatus = Int(resultSet.int(forColumn: "CountStatus"))
                    StaysStatus.append([])
                    for _ in 0...contStatus-1 {
                        StaysStatus[0].append([:])
                    }
                    
                }else{
                    Status.append(resultSet.string(forColumn: "OrderNo")!)
                    contStatus = Int(resultSet.int(forColumn: "CountStatus"))
                    StaysStatus.append([])
                    for _ in 0...contStatus-1 {
                        StaysStatus[Index].append([:])
                    }
                    
                }
                Index = Index + 1
            }
        }
        
        let xCountStatus = Int(CountStatusTot)
        let xCountStays = Int(CountStays)
        var sCount: Int = 0
        
        for xIndex in 0...xCountStatus-1 {
            sCount = 0
            for yIndex in 0...xCountStays-1 {
                if (Status[xIndex]==StayInfo[yIndex]["OrderNo"]){
                    StaysStatus[xIndex][sCount] = StayInfo[yIndex]
                    sCount = sCount + 1
                }
                
            }
            
        }
        
        sharedInstance.database!.close()
        
        return StaysStatus
    }
    func getAccountInfo(_ StayInfoID: String, PeopleFDeskID: String) -> [Dictionary<String, String>] {
        var AccountInfo: [Dictionary<String, String>]
        var Index: Int = 0
        var strQuery: String = ""
        
        sharedInstance.database!.open()
        
        if (PeopleFDeskID=="0"){
            strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ?"
        }else{
            strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =?"
        }
        
        AccountInfo = []
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID,PeopleFDeskID])
        if (resultSet != nil) {
            while resultSet.next() {
                AccountInfo.append([:])
                AccountInfo[Index]["StayInfoID"] = resultSet.string(forColumn: "StayInfoID")
                AccountInfo[Index]["DatabaseName"] = resultSet.string(forColumn: "DatabaseName")
                AccountInfo[Index]["fkAccTrxID"] = resultSet.string(forColumn: "fkAccTrxID")
                AccountInfo[Index]["Voucher"] = resultSet.string(forColumn: "Voucher")
                AccountInfo[Index]["PlaceDesc"] = resultSet.string(forColumn: "PlaceDesc")
                AccountInfo[Index]["Amount"] = resultSet.string(forColumn: "Amount")
                AccountInfo[Index]["TrxDate"] = resultSet.string(forColumn: "TrxDate")
                AccountInfo[Index]["PersonID"] = resultSet.string(forColumn: "PersonID")
                AccountInfo[Index]["SubTotal"] = resultSet.string(forColumn: "SubTotal")
                AccountInfo[Index]["Tips"] = resultSet.string(forColumn: "Tips")
                AccountInfo[Index]["Cashier"] = resultSet.string(forColumn: "Cashier")
                AccountInfo[Index]["TrxTypeCode"] = resultSet.string(forColumn: "TrxTypeCode")
                AccountInfo[Index]["TrxTime"] = resultSet.string(forColumn: "TrxTime")
                AccountInfo[Index]["PeopleFDeskID"] = resultSet.string(forColumn: "PeopleFDeskID")
                Index = Index + 1
            }
        }
        
        sharedInstance.database!.close()
        return AccountInfo
    }
    
    func getDateAccountInfo(_ AccountInfo: [Dictionary<String, String>], StayInfoID: String, PeopleFDeskID: String) -> [[Dictionary<String, String>]] {
        var strDate: [String]
        var DateAccountInfo: [[Dictionary<String, String>]]
        
        var CountAccountTot: Int32 = 0
        var CountTrx: Int = 0
        var Index: Int = 0
        var CountTotTrx: Int = 0
        var strQuery: String = ""
        var strQueryAcc: String = ""
        
        CountTotTrx = AccountInfo.count
        
        //CountAccountTot = ModelManager.instance.getCount("SELECT COUNT(*) FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)", strArgs: StayInfoID)
        
        sharedInstance.database!.open()

        if (PeopleFDeskID=="0"){
            strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)"
        }else{
            strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate)"
        }
        
        let resultCount: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID, PeopleFDeskID])
        if (resultCount != nil) {
            while resultCount.next() {
                CountAccountTot = resultCount.int(forColumn: "CountAccountTot")
            }
        }
        
        DateAccountInfo = []
        strDate = [""]
        
        if (PeopleFDeskID=="0"){
            strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate ORDER BY TrxDate DESC"
        }else{
            strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate ORDER BY TrxDate DESC"
        }
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQueryAcc, withArgumentsIn: [StayInfoID, PeopleFDeskID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                if (Index==0){
                    strDate[0] = resultSet.string(forColumn: "TrxDate")!
                    CountTrx = Int(resultSet.int(forColumn: "CountTrx"))
                    DateAccountInfo.append([])
                    for _ in 0...CountTrx-1 {
                        DateAccountInfo[0].append([:])
                    }
                    
                }else{
                    strDate.append(resultSet.string(forColumn: "TrxDate")!)
                    CountTrx = Int(resultSet.int(forColumn: "CountTrx"))
                    DateAccountInfo.append([])
                    for _ in 0...CountTrx-1 {
                        DateAccountInfo[Index].append([:])
                    }
                    
                }
                Index = Index + 1
            }
        }
        
        let xCountStatus = Int(CountAccountTot)
        let xCountStays = Int(CountTotTrx)
        var sCount: Int = 0
        
        for xIndex in 0...xCountStatus-1 {
            sCount = 0
            for yIndex in 0...xCountStays-1 {
                if (strDate[xIndex]==AccountInfo[yIndex]["TrxDate"]){
                    DateAccountInfo[xIndex][sCount] = AccountInfo[yIndex]
                    sCount = sCount + 1
                }
                
            }
        
        }
        
        sharedInstance.database!.close()
        
        return DateAccountInfo
    }

    
    func getAccountPeople(_ StayInfoID: String) -> [Dictionary<String, String>] {
        
        var Stays: [Dictionary<String, String>]
        var DataStays = [String:String]()
        
        var Index: Int = 0
        var TotalRow: Int = 0
        sharedInstance.database!.open()
        
        Stays = []
        
        //Para obtener el total de registros
        let resultSetCount: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [StayInfoID])
        
        if (resultSetCount != nil) {
            
            //Obtenmos el total de registros
            while resultSetCount.next() {
                TotalRow = TotalRow + 1
            }
            
            //El numero de registros encontrados
            for _ in 0...TotalRow-1 {
                Stays.append([:])
            }
        }
        
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [StayInfoID])
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                
                DataStays["StayInfoID"] = resultSet.string(forColumn: "StayInfoID")
                DataStays["DatabaseName"] = resultSet.string(forColumn: "DatabaseName")
                DataStays["PersonID"] = resultSet.string(forColumn: "PersonID")
                DataStays["FullName"] = resultSet.string(forColumn: "FullName")
                DataStays["FirstName"] = resultSet.string(forColumn: "FirstName")
                DataStays["MiddleName"] = resultSet.string(forColumn: "MiddleName")
                DataStays["LastName"] = resultSet.string(forColumn: "LastName")
                DataStays["SecondLName"] = resultSet.string(forColumn: "SecondLName")
                DataStays["EmailAddress"] = resultSet.string(forColumn: "EmailAddress")
                DataStays["PeopleFdeskID"] = resultSet.string(forColumn: "PeopleFdeskID")
                DataStays["YearBirthDay"] = resultSet.string(forColumn: "YearBirthDay")
                DataStays["ynPrimary"] = resultSet.string(forColumn: "ynPrimary")
                DataStays["ynPreRegisterAvailable"] = resultSet.string(forColumn: "ynPreRegisterAvailable")
                DataStays["NumOfPeopleForStay"] = resultSet.string(forColumn: "NumOfPeopleForStay")
                DataStays["Age"] = resultSet.string(forColumn: "Age")
                DataStays["pkPreRegisterID"] = resultSet.string(forColumn: "pkPreRegisterID")
                DataStays["PreRegisterTypeDesc"] = resultSet.string(forColumn: "PreRegisterTypeDesc")
                DataStays["GuestType"] = resultSet.string(forColumn: "GuestType")
                Stays[Index] = DataStays
                
                Index = Index + 1
            }
        }
        
        sharedInstance.database!.close()
        return Stays
        
    }
    
    
    func getPeopleNames(_ StayInfoID: String) -> [String] {
        var People: [String]

        sharedInstance.database!.open()
        
        People = ["ALL"]
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [StayInfoID])
        if (resultSet != nil) {
            while resultSet.next() {
                
               People.append(resultSet.string(forColumn: "FirstName")!)
                
            }
        }
        
        sharedInstance.database!.close()
        return People
    }
    
    func getPeoplePrimaryName(_ StayInfoID: String) -> String {
        var People: String = ""

        sharedInstance.database!.open()

        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = ? AND s.PrimaryPeopleID = p.personID", withArgumentsIn: [StayInfoID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                People = resultSet.string(forColumn: "FullName")!
                
            }
        }
        
        sharedInstance.database!.close()
        return People
    }
    func getPeopleFDESKID() -> String {
        var People: String = ""
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT p.* FROM tblPerson p inner join tblLogin l on l.PersonalID = p.personID", withArgumentsIn: [])
        if (resultSet != nil) {
            while resultSet.next() {
                
                People = resultSet.string(forColumn: "PeopleFdeskID")!
                
            }
        }
        
        sharedInstance.database!.close()
        return People
    }
    
    func getPeopleNamesPay(_ StayInfoID: String, PeopleFDeskID: String) -> String {
        var People: String = ""
        var strQuery: String = ""
        
        if (PeopleFDeskID=="0"){
            strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
        }else{
            strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ? AND PeopleFDeskID =?"
        }
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID,PeopleFDeskID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                People = People + resultSet.string(forColumn: "FullName")! + ", "
                
            }
            if People != ""{
                
                let strpre:  String = People
                
                let start = strpre.index(strpre.startIndex, offsetBy: 0)
                let end = strpre.index(strpre.endIndex, offsetBy: -2)
                let range = start..<end
                
                let mySubstring = strpre[range]
                
                People = String(mySubstring)
                
            }
            
        }

        sharedInstance.database!.close()
        return People
    }

    func getPeopleID(_ StayInfoID: String) -> [String] {
        var People: [String]
        
        sharedInstance.database!.open()
        
        People = ["0"]
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ? ORDER BY rowid ASC", withArgumentsIn: [StayInfoID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                if (resultSet.string(forColumn: "PeopleFDeskID") == "0"){
                People.append("-1")
                }else{
                People.append(resultSet.string(forColumn: "PeopleFDeskID")!)
                }
            }
        }
        
        sharedInstance.database!.close()
        return People
    }

    func getCount(_ strQuery: NSString, strArgs: NSString) -> Int32 {
        var resultID: Int32 = 0
        
        sharedInstance.database!.open()
        
        let resultCount = sharedInstance.database!.intForQuery(strQuery as String,strArgs)
        
        if (resultCount == nil){
            resultID = 0
        }else{
            if (String(describing: resultCount) == ""){
                resultID = 0
            }else{
                resultID = Int32(resultCount!)
            }
            
        }
        
        sharedInstance.database!.close()
        
        return resultID
    }

    func getPeopleAmount(_ StayInfoID: String, PeopleFDeskID: String) -> String{
        var Amount: String=""
        var strQuery: String=""
        
        sharedInstance.database!.open()
        
        if (PeopleFDeskID=="0"){
            strQuery = "SELECT CASE WHEN SUM(Amount) > 0 THEN SUM(Amount) ELSE 0 END as Amount FROM tblAccount where StayInfoID = ?"
        }else{
            strQuery = "SELECT CASE WHEN SUM(Amount) > 0 THEN SUM(Amount) ELSE 0 END as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
        }
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID, PeopleFDeskID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Amount = resultSet.string(forColumn: "Amount")!
                
            }
        }
        
        sharedInstance.database!.close()
        return Amount
    }
    
    func getLastTrx(_ StayInfoID: String) -> String{
        var fkAccTrxID: String=""
        var strQuery: String=""

        sharedInstance.database!.open()
        
        strQuery = "SELECT fkAccTrxID FROM tblAccount where StayInfoID = ? ORDER BY fkAccTrxID DESC LIMIT 1"

        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                fkAccTrxID = resultSet.string(forColumn: "fkAccTrxID")!
                
            }
        }
        
        sharedInstance.database!.close()
        return fkAccTrxID
    }
    
    func getHeaderTrx(_ fkAccTrxID: String) -> Dictionary<String, String>{
        var strQuery: String=""
        var Account: Dictionary<String, String>
        
        Account = [:]
        
        sharedInstance.database!.open()
        //|| ' ' || TrxTime
        strQuery = "SELECT PlaceDesc, TrxDate as TrxTime, FullName, SubTotal, Tips, Amount, a.StayInfoID FROM tblAccount a LEFT JOIN tblPerson p ON p.PersonID = a.PersonID WHERE a.fkAccTrxID = ?"
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [fkAccTrxID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Account["PlaceDesc"] = resultSet.string(forColumn: "PlaceDesc")
                Account["TrxTime"] = resultSet.string(forColumn: "TrxTime")
                Account["FullName"] = resultSet.string(forColumn: "FullName")
                Account["SubTotal"] = resultSet.string(forColumn: "SubTotal")
                Account["Tips"] = resultSet.string(forColumn: "Tips")
                Account["Amount"] = resultSet.string(forColumn: "Amount")
                Account["StayInfoID"] = resultSet.string(forColumn: "StayInfoID")
                
            }
        }
        
        sharedInstance.database!.close()
        return Account
    }
    
    func getVoucherDetail(_ fkAccTrxID: String) -> [Dictionary<String, String>]{
        var strQuery: String=""
        var VoucherDetail: [Dictionary<String, String>]
        var index: Int = 0
        VoucherDetail = []

        sharedInstance.database!.open()
        
        strQuery = "SELECT ItemCode, Quantity, ItemDesc, Total FROM tblAccountDetail WHERE fkAccTrxID = ?"
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [fkAccTrxID])
        if (resultSet != nil) {
            while resultSet.next() {
                VoucherDetail.append([:])
                VoucherDetail[index]["ItemCode"] = resultSet.string(forColumn: "ItemCode")
                VoucherDetail[index]["Quantity"] = resultSet.string(forColumn: "Quantity")
                VoucherDetail[index]["ItemDesc"] = resultSet.string(forColumn: "ItemDesc")
                VoucherDetail[index]["Total"] = resultSet.string(forColumn: "Total")
                index = index + 1
            }
        }
        
        sharedInstance.database!.close()
        return VoucherDetail
    }
    
    func getPeopleEmail(_ PersonalID: String) -> Dictionary<String, String> {
        var People: Dictionary<String, String>
        People = [:]

        sharedInstance.database!.open()

        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM tblLogin WHERE PersonalID = ?", withArgumentsIn: [PersonalID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                People["Email"] = resultSet.string(forColumn: "Email")
                People["Lenguage"] = resultSet.string(forColumn: "Lenguage")
                
            }
        }
        
        sharedInstance.database!.close()
        return People
    }
    
    func getTrxID(_ fkAccTrxID: String) -> Bool{
        var strQuery: String=""
        var ynExist: Bool=false
        
        var Index: Int = 0
        sharedInstance.database!.open()
        
        strQuery = "SELECT fkAccTrxID FROM tblAccount where fkAccTrxID = ?"
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [fkAccTrxID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Index = 1
                
            }
        }
        
        sharedInstance.database!.close()
        
        if Index == 1{
            ynExist = true
        }else{
            ynExist = false
        }
        
        return ynExist
    }
    func getStayInfoID(_ StayInfoID: String, DataBaseName: String, PrimaryPeopleID: String) -> Bool{
        var strQuery: String=""
        var ynExist: Bool=false
        
        var Index: Int = 0
        sharedInstance.database!.open()
        
        strQuery = "SELECT StayInfoID FROM tblStay s WHERE StayInfoID = ? and DataBaseName = ? and PrimaryPeopleID = ?"
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID, DataBaseName, PrimaryPeopleID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Index = 1
                
            }
        }
        
        sharedInstance.database!.close()
        
        if Index == 1{
            ynExist = true
        }else{
            ynExist = false
        }
        
        return ynExist
    }

    func getAbsPeopleAmount(_ StayInfoID: String, PeopleFDeskID: String) -> String{
        var Amount: String=""
        var strQuery: String=""
        
        sharedInstance.database!.open()
        
        if (PeopleFDeskID=="0"){
            strQuery = "SELECT CASE WHEN SUM(Amount) > 0 THEN SUM(Amount) ELSE 0 END as Amount FROM tblAccount where StayInfoID = ? AND Amount > 0"
        }else{
            strQuery = "SELECT CASE WHEN SUM(Amount) > 0 THEN SUM(Amount) ELSE 0 END as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =? AND Amount > 0"
        }
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: [StayInfoID, PeopleFDeskID])
        if (resultSet != nil) {
            while resultSet.next() {
                
                Amount = resultSet.string(forColumn: "Amount")!
                
            }
        }
        
        sharedInstance.database!.close()
        return Amount
    }

}
