//
//  Clasificacion.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/21/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Clasificacion : NSManagedObject

@property (nonatomic, retain) NSNumber * fnClasificacion;
@property (nonatomic, retain) NSString * fcDescripcion;
@property (nonatomic, retain) NSNumber * ynMealPlan;

@end
