//
//  RRTableItem.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 9/5/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRTableItem : UITableViewCell

@property (strong,nonatomic) NSNumber *folioID;
@property (strong,nonatomic) NSNumber *sillaNo;
@property (strong,nonatomic) NSNumber *clasificationID;
@property (strong,nonatomic) NSString *count;
@property (strong,nonatomic) NSString *amount;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *sent;
@property (strong,nonatomic) NSString *invoiced;
@property (strong,nonatomic) NSString *comments;
@property (strong,nonatomic) UIColor *color;
@property (assign,nonatomic) BOOL itemEditable;
@property (assign,nonatomic) BOOL forCancellation;

@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblChairNo;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;


-(void)setFolioID:(NSNumber *)folioID;
-(void)setSillaNo:(NSNumber *)sillaNo;
-(void)setClasificationID:(NSNumber *)clasificationID;
-(void)setCount:(NSString *)count;
-(void)setAmount:(NSString *)amount;
-(void)setCode:(NSString *)code;
-(void)setDescription:(NSString *)description;
-(void)setStatus:(NSString *)status;
-(void)setSent:(NSString *)sent;
-(void)setInvoiced:(NSString *)invoiced;
-(void)setComments:(NSString *)comments;

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
       withComments:(NSString *)comments;


@end
