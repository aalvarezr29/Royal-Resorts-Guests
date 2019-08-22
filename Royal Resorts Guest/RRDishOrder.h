//
//  RRDishOrder.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/29/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Platillo.h"

@interface RRDishOrder : NSObject

@property NSInteger quantity;
@property NSInteger chair;
@property (strong, nonatomic) NSString *comments;
@property BOOL ynSentToKitchen;
@property (strong, nonatomic) Platillo *dish;
@property (strong, nonatomic) NSDecimalNumber *price;
@property (strong,nonatomic) NSNumber *folioID;

@end
