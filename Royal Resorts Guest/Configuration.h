//
//  Configuration.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/23/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Configuration : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;

@end
