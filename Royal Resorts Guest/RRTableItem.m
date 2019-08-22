//
//  RRTableItem.m
//  iRest
//
//  Created by Blas Ramos on 9/2/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import "RRTableItem.h"

@implementation RRTableItem

@synthesize folioID = _folioID;
@synthesize sillaNo = _sillaNo;
@synthesize clasificationID = _clasificationID;
@synthesize count = _count;
@synthesize amount = _amount;
@synthesize code = _code;
@synthesize description = _description;
@synthesize status = _status;                       // C = Cancelado ...
@synthesize sent = _sent;                           // N = No enviado ... Y = Enviado a cocina
@synthesize invoiced = _invoiced;                   // N = No Facturado ... Y = Facturado
@synthesize comments = _comments;
@synthesize forCancellation = _forCancellation;  //Si esta encendido indica que se trata de una cancelacion


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

-(void)setFolioID:(NSNumber *)folioID
{
    if (folioID && [folioID class] != [NSNull class])
    {
        _folioID = folioID;
    }
    else
    {
        _folioID = [NSNumber numberWithInteger:0];
    }
}

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

-(void)setClasificationID:(NSNumber *)clasificationID
{
    if (clasificationID && [clasificationID class] != [NSNull class])
    {
        _clasificationID = clasificationID;
    }
    else
    {
        _clasificationID = [NSNumber numberWithInteger:0];;
    }
}

-(void)setCount:(NSString *)count
{
    if (count && [count class] != [NSNull class])
    {
        _count = count;
    }
    else
    {
        _count = @"0.0";
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

-(void)setCode:(NSString *)code
{
    if (code && [code class] != [NSNull class])
    {
        _code = code;
    }
    else
    {
        _code = @"";
    }
}

-(void)setDescription:(NSString *)description
{
    if (description && [description class] != [NSNull class])
    {
        _description = description;
    }
    else
    {
        _description = @"";
    }
}

-(void)setStatus:(NSString *)status
{
    if (status && [status class] != [NSNull class])
    {
        _status = status;
    }
    else
    {
        _status = @"";
    }
}

-(void)setSent:(NSString *)sent
{
    if (sent && [sent class] != [NSNull class])
    {
        _sent = sent;
    }
    else
    {
        _sent = @"";
    }
}

-(void)setInvoiced:(NSString *)invoiced
{
    if (invoiced && [invoiced class] != [NSNull class])
    {
        _invoiced = invoiced;
    }
    else
    {
        _invoiced = @"";
    }
}

-(void)setComments:(NSString *)comments
{
    if (comments && [comments class] != [NSNull class])
    {
        _comments = comments;
    }
    else
    {
        _comments = @"";
    }
}

-(void)newTableItem: (NSString *)code
    withDescription:(NSString *)description
        withFolioID:(NSNumber *)folioID
withClasificationID:(NSNumber *)clasificationID
          withPrice:(NSString *)amount
            withQty:(NSString *)count
          inSillaNo:(NSNumber *)sillaNo
         withStatus:(NSString *)status
             isSent:(NSString *)sent
         isInvoiced:(NSString *)invoidec
       withComments:(NSString *)comments
{
    
    [self setCode:code];
    [self setDescription:description];
    [self setFolioID:folioID];
    [self setClasificationID:clasificationID];
    [self setAmount:amount];
    [self setCount:count];
    [self setSillaNo:sillaNo];
    [self setStatus:status];
    [self setSent:sent];
    [self setInvoiced:invoidec];
    [self setComments:comments];
    
    //Validaciones para setear las propiedades de color y itemEditable
    if ([self.sent isEqualToString:@"Y"] || [self.invoiced isEqualToString:@"Y"] || [self.status isEqualToString:@"C"])
    {
        //NO Editable
        self.itemEditable = FALSE;
        
        //Color
        if ([self.sent isEqualToString:@"Y"])
        {
            self.color = [UIColor redColor];
        }
        if ([self.invoiced isEqualToString:@"Y"])
        {
            self.color = [UIColor blueColor];
        }
        if ([self.status isEqualToString:@"C"])
        {
            self.color = [UIColor brownColor];
        }
    }
    else
    {
        //Editable
        self.itemEditable = TRUE;
        
        self.color = [UIColor colorWithRed:0.3 green:0.52 blue:0.13 alpha:1.0];
    }
    
}

@end
