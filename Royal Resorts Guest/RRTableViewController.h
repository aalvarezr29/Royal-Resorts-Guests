//
//  RRTableViewController.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/28/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRTableAddedDelegate.h"
@interface RRTableViewController : UICollectionViewController<RRTableAddedDelegate>


//@property (strong,nonatomic) NSArray *tableSource;
@property (strong,nonatomic) NSString *strSelectedTable;
//@property (strong,nonatomic) NSString *strTables;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAddTable;

@end
