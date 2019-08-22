//
//  RRChairItem.m
//  iRest
//
//  Created by Angel Itza on 8/22/14.
//  Copyright (c) 2014 Royal Resorts. All rights reserved.
//


#import "RRChairItem.h"

@implementation RRChairItem


@synthesize sillaNo = _sillaNo;
@synthesize amount = _amount;
@synthesize folio = _folio;
@synthesize ynAplicado = _ynAplicado;
@synthesize ynConPlatillosRefine = _ynConPlatillosRefine;

@synthesize formaPago = _formaPago;
@synthesize posicion = _posicion;
@synthesize propina = _propina;
@synthesize nombre = _nombre;
@synthesize club = _club;
@synthesize villa = _villa;
@synthesize tarjeta = _tarjeta;
@synthesize IEPS = _IEPS;
@synthesize IVA = _IVA;
@synthesize mealPlanData = _mealPlanData;

//@synthesize imagenCirculo = _imagenCirculo;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma class functions


-(void)setSillaNo:(NSNumber *)sillaNo
{
    if (sillaNo && [sillaNo class] != [NSNull class])
    {
        _sillaNo = sillaNo;
    }
    else
    {
        _sillaNo = [NSNumber numberWithInteger:0];;
    }
}


-(void)setAmount:(NSString *)amount
{
    if (amount && [amount class] != [NSNull class])
    {
        _amount = amount;
    }
    else
    {
        _amount = @"0.0";
    }
}


-(void)setFolio:(NSString *)folio
{
    if (folio && [folio class] != [NSNull class])
    {
        //_folio = @"Voucher  ";
        //_folio = [ _folio stringByAppendingString: folio];
        _folio =
        _folio = folio;
        
        
    }
    else
    {
        _folio = @"";
    }
}


-(void)setynAplicado:(NSNumber *)ynAplicado
{
    if (ynAplicado && [ynAplicado class] != [NSNull class])
    {
        _ynAplicado = ynAplicado;
    }
    else
    {
        _ynAplicado = [NSNumber numberWithInteger:0];
    }
}

-(void)setynConPlatillosRefine:(NSNumber *)ynConPlatillosRefine
{
    if (ynConPlatillosRefine && [ynConPlatillosRefine class] != [NSNull class])
    {
        _ynConPlatillosRefine = ynConPlatillosRefine;
    }
    else
    {
        _ynConPlatillosRefine = [NSNumber numberWithInteger:0];
    }
}


-(void)setFormaPago:(NSString *)formaPago
{
    if (formaPago && [formaPago class] != [NSNull class])
    {
        _formaPago = formaPago;
    }
    else
    {
        _formaPago = @"";
    }
}


-(void)setPosicion:(NSString *)posicion
{
    if (posicion && [posicion class] != [NSNull class])
    {
        _posicion = posicion;
    }
    else
    {
        _posicion = @"0";
    }
}


-(void)setPropina:(NSString *)propina
{
    if (propina && [propina class] != [NSNull class])
    {
        _propina = propina;
    }
    else
    {
        _propina = @"0.0";
    }
}


-(void)setNombre:(NSString *)nombre
{
    if (nombre && [nombre class] != [NSNull class])
    {
        _nombre = nombre;
    }
    else
    {
        _nombre = @"";
    }
}

-(void)setClub:(NSString *)club
{
    if (club && [club class] != [NSNull class])
    {
        _club = club;
    }
    else
    {
        _club = @"";
    }
}

-(void)setVilla:(NSString *)villa
{
    if (villa && [villa class] != [NSNull class])
    {
        _villa = villa;
    }
    else
    {
        _villa = @"";
    }
}

-(void)setTarjeta:(NSString *)tarjeta
{
    if (tarjeta && [tarjeta class] != [NSNull class])
    {
        _tarjeta = tarjeta;
    }
    else
    {
        _tarjeta = @"";
    }
}

-(void)setIEPS:(NSString *)IEPS
{
    if (IEPS && [IEPS class] != [NSNull class])
    {
        _IEPS = IEPS;
    }
    else
    {
        _IEPS = @"0.0";
    }
}

-(void)setIVA:(NSString *)IVA
{
    if (IVA && [IVA class] != [NSNull class])
    {
        _IVA = IVA;
    }
    else
    {
        _IVA = @"";
    }
}

-(void)setMealPlanData:(NSString *)mealPlanData
{
    if (mealPlanData && [mealPlanData class] != [NSNull class])
    {
        _mealPlanData = mealPlanData;
    }
    else
    {
        _mealPlanData = @"";
    }
}



//-(void)setimagenCirculo:(NSObject *)imagenCirculo
//{
    //if (imagenCirculo && [imagenCirculo class] != [NSNull class])
    //{
        //_imagenCirculo = imagenCirculo;
    //}
    
//}



-(void)newChairItem: (NSNumber *)sillaNo
        withAmount:(NSString *)amount
        withFolio:(NSString *)folio
        withynAplicado:(NSNumber *)ynAplicado
        withynConPlatillosRefine:(NSNumber *)ynConPlatillosRefine
        withFormaPago:(NSString *)formaPago
        withPosicion:(NSString *)posicion
        withPropina:(NSString *)propina
        withNombre:(NSString *)nombre
        withClub:(NSString *)club
        withVilla:(NSString *)villa
        withTarjeta:(NSString *)tarjeta
        withIEPS:(NSString *)IEPS
        withIVA:(NSString *)IVA
        withMealPlanData:(NSString *)mealPlanData

        //withimagenCirculo:(NSObject *)imagenCirculo


{
    
    [self setSillaNo:sillaNo];
    [self setAmount:amount];
    [self setFolio:folio];
    [self setYnAplicado:ynAplicado];
    [self setYnConPlatillosRefine:ynConPlatillosRefine];
    
    [self setFormaPago:formaPago];
    [self setPosicion:posicion];
    [self setPropina:propina];
    [self setNombre:nombre];
    [self setClub:club];
    [self setVilla:villa];
    [self setTarjeta:tarjeta];
    [self setIEPS:IEPS];
    [self setIVA:IVA];
    [self setMealPlanData:mealPlanData];
    
    //[self setimagenCirculo:imagenCirculo];
    
    //self.itemEditable = TRUE;
    
    
    //self.ynAplicado = [NSNumber numberWithInteger:1];
    

    //Si ya fue aplicado pintamos la celda de rojo
    if ([self.ynAplicado intValue] == 1) {
        self.color = [UIColor redColor];
    }
    
    
    
   // self.color = [UIColor colorWithRed:0.3 green:0.52 blue:0.13 alpha:1.0];



    
    
}




@end



