//
//  Platillo.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/21/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Platillo : NSManagedObject

@property (nonatomic, retain) NSString * fcCode;
@property (nonatomic, retain) NSString * fcDesc;
@property (nonatomic, retain) NSNumber * fnClasificacion;
@property (nonatomic, retain) NSDecimalNumber * ffNeto;
@property (nonatomic, retain) NSString * fcIVA;
@property (nonatomic, retain) NSNumber * iOpenItem;


@end
