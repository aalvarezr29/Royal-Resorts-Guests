//
//  RRChairItem.h
//  iRest
//
//  Created by Angel Itza on 8/22/14.
//  Copyright (c) 2014 Royal Resorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRChairItem : UITableViewCell


@property (strong,nonatomic) NSNumber *sillaNo;
@property (strong,nonatomic) NSString *amount;
@property (strong,nonatomic) NSString *folio;
//@property (strong,nonatomic) NSObject *imagenCirculo;
@property (strong,nonatomic) UIColor *color;
@property (assign,nonatomic) BOOL itemEditable;
@property (strong,nonatomic) NSNumber *ynAplicado;
@property (strong,nonatomic) NSNumber *ynConPlatillosRefine;

@property (strong,nonatomic) NSString *formaPago;
@property (strong,nonatomic) NSString *posicion;
@property (strong,nonatomic) NSString *propina;
@property (strong,nonatomic) NSString *nombre;
@property (strong,nonatomic) NSString *club;
@property (strong,nonatomic) NSString *villa;
@property (strong,nonatomic) NSString *tarjeta;
@property (strong,nonatomic) NSString *IEPS;
@property (strong,nonatomic) NSString *IVA;
@property (strong,nonatomic) NSString *mealPlanData;

@property (weak, nonatomic) IBOutlet UILabel *lblChairNo;
@property (weak, nonatomic) IBOutlet UITextField *txtImporte;
@property (weak, nonatomic) IBOutlet UITextField *txtPropina;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UITextField *txtFolio;


//@property (weak, nonatomic) IBOutlet UIImageView *ivimagenCirculo;


-(void)setSillaNo:(NSNumber *)sillaNo;
-(void)setAmount:(NSString *)amount;
-(void)setFolio:(NSString *)folio;
-(void)setynAplicado:(NSNumber *)ynAplicado;
-(void)setynConPlatillosRefine:(NSNumber *)ynConPlatillosRefine;

-(void)setFormaPago:(NSString *)formaPago;
-(void)setPosicion:(NSString *)posicion;
-(void)setPropina:(NSString *)propina;
-(void)setNombre:(NSString *)nombre;
-(void)setClub:(NSString *)club;
-(void)setVilla:(NSString *)villa;
-(void)setTajeta:(NSString *)tarjeta;
-(void)setIEPS:(NSString *)IEPS;
-(void)setIVA:(NSString *)IVA;
-(void)setMealPlanData:(NSString *)mealPlanData;

//-(void)setImagenCirculo:(NSObject *)imagenCirculo;

-(void)newChairItem: (NSNumber *)sillaNo
            withAmount:(NSString *)amount
            withFolio:(NSString *)folio
            withynAplicado: (NSNumber *)ynAplicado
            withynConPlatillosRefine: (NSNumber *)ynConPlatillosRefine
            withFormaPago:(NSString *)formaPago
            withPosicion:(NSString *)posicion
            withPropina:(NSString *)propina
            withNombre:(NSString *)nombre
            withClub:(NSString *)club
            withVilla:(NSString *)villa
            withTarjeta:(NSString *)tarjeta
            withIEPS:(NSString *)IEPS
            withIVA:(NSString *)IVA
            withMealPlanData:(NSString *)mealPlanData;

            //withimagenCirculo:(NSObject *)imagenCirculo;


@end









