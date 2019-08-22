//
//  RRTableViewController.m
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/28/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import "RRTableViewController.h"
#import "RRTable.h"
#import "RRTableSection.h"
#import "SWRevealViewController.h"
#import "RRMainMenuViewController.h"
#import "RRNewTableViewController.h"

@interface RRTableViewController ()

@end

@implementation RRTableViewController
{
@private NSMutableArray *_waiterTables;
@private NSMutableArray *_waiterNames;
@private RRIndicatorView *_waitIndicator;
}

@synthesize sidebarButton = _sidebarButton;
@synthesize btnAddTable = _btnAddTable;
@synthesize strSelectedTable = _strSelectedTable;

//Delegate methods

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setTheme];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _waiterTables = [[NSMutableArray alloc]init];
    _waiterNames = [[NSMutableArray alloc]init];
    
    //Indicador de espera
    _waitIndicator = [[RRIndicatorView alloc]initWithTitle:@"Cargando mesas"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
    
    if (ApplicationDelegate.isLogin == NO)
    {
        [_waitIndicator startIndicator];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                       ^{
                           if ([ApplicationDelegate internetConnectionReachable]) {
                               [self setupOpenedTablesBackground];
                           }
                           else
                           {
                               //No hay conexion a internet, solo avisamos y salimos
                               UIAlertView *alert    = [[UIAlertView alloc] initWithTitle:@"iRest" message:ApplicationDelegate.reachabilityErrorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                               [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                           }
                           [_waitIndicator performSelectorOnMainThread:@selector(stopIndicator) withObject:nil waitUntilDone:YES];
                       });
    }
    
    //[self setupOpenedTables];
    //[[self collectionView] reloadData];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"segueTableDetail"]) {
        
        RRMainMenuViewController *tableDetail = segue.destinationViewController;
        
        if ([[sender class] isSubclassOfClass:[RRTable class]])
        {
            [tableDetail setStrTableNo:[sender strTableNo]];
        }
        else
        {
            [tableDetail setStrTableNo:_strSelectedTable];
        }
        
    }
    else if ([segue.identifier isEqualToString:@"segueNewTable"])
    {
        RRNewTableViewController *newTable = segue.destinationViewController;
        newTable.delegate = self;
        
        //Le mandamos un array con todas las mesas abiertas
        NSMutableArray *currentTables = [[NSMutableArray alloc]init];
        for (NSArray *tmp in _waiterTables)
        {
            [currentTables addObjectsFromArray:tmp];
        }
        
        newTable.openedTables = currentTables;
        
    }
    
}


#pragma mark - CollectionView functions

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    RRTableSection * tableSection = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"openedTableSection" forIndexPath:indexPath];
    
    tableSection.lblTitle.text = (NSString *)_waiterNames[indexPath.section];
    
    [tableSection.lblTitle setTextColor:[UIColor whiteColor]];
    [tableSection.lblTitle setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar.png"]]];
    
    return tableSection;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_waiterTables count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_waiterTables[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RRTable *openedTable = [collectionView dequeueReusableCellWithReuseIdentifier:@"openedTable" forIndexPath:indexPath];
    
    NSArray *current = [[NSArray alloc]initWithArray:_waiterTables[indexPath.section]];
    
    openedTable.strTableNo = current[indexPath.row];
    [openedTable.lblTitle setText:current[indexPath.row]];
    
    [openedTable.lblTitle setTextColor:[UIColor brownColor]];
    openedTable.imgPicture.image = [UIImage imageNamed:@"newTable.png"];
    
    return openedTable;
}

#pragma mark - newTableAddedDelegate implementation
-(void)newTableAdded:(NSString *)tableNumber
{
    _strSelectedTable = tableNumber;
    [self performSegueWithIdentifier:@"segueTableDetail" sender:self];
    
}


-(void)setupOpenedTables
{
    
    if (ApplicationDelegate.dataBaseLocation != nil)
    {
        
        RRDataSet *dtsOpenedTables = [RRRestaurantService spGetOpenedTables:ApplicationDelegate.userPassword];
        
        /*
         NSInteger index = 0;
         for (index = 0; index <= 10000; index = index + 1) {
         NSLog(@"%d", index);
         }
         */
        
        if (dtsOpenedTables)
        {
            if ([dtsOpenedTables.tables count] > 1)
            {
                RRDataTable *tblResult = (RRDataTable*)[dtsOpenedTables.tables objectAtIndex:0];
                RRDataRow *rowResult = (RRDataRow*)[tblResult.rows objectAtIndex:0];
                NSNumber * iRes = [[NSNumber alloc] init];
                
                iRes = (NSNumber*) [rowResult getColumnByName:@"iResult"].content;
                
                if ([iRes intValue] >= 0)
                {
                    [_waiterTables removeAllObjects];
                    [_waiterNames removeAllObjects];
                    
                    RRDataTable *table = (RRDataTable*)[dtsOpenedTables.tables objectAtIndex:1];
                    
                    for (RRDataRow *r in table.rows)
                    {
                        NSString *openedTables;
                        NSString *waiterName;
                        
                        //Obtenemos el nombre del mesero y sus mesas abiertas
                        openedTables = (NSString*)[r getColumnByName:@"TABLES"].content;
                        waiterName = (NSString*)[r getColumnByName:@"USERNAME"].content;
                        
                        //Validamos que la cadena de tablas no empiece ni termine con ','
                        if ([openedTables hasPrefix:@","])
                        {
                            openedTables = [openedTables substringFromIndex:1];
                        }
                        
                        if ([openedTables hasSuffix:@","])
                        {
                            openedTables = [openedTables substringToIndex:openedTables.length - 1];
                        }
                        
                        //Ordenamos las mesas
                        NSArray *tables = [[NSArray alloc] initWithArray:[openedTables componentsSeparatedByString:@","]];
                        NSMutableArray *sortTables;
                        
                        if ([tables count] > 1)
                        {
                            
                            sortTables = [[NSMutableArray alloc]initWithArray:
                                          [tables sortedArrayUsingComparator:
                                           ^NSComparisonResult(NSString *str1, NSString *str2)
                                           {
                                               return [str1 compare:str2 options:NSNumericSearch];
                                           }
                                           ]
                                          ];
                            
                        }
                        else
                        {
                            sortTables = (NSMutableArray *)[tables sortedArrayUsingSelector:@selector(localizedCompare:)];
                        }
                        
                        //Agregamos nombre del mesero y sus mesas abiertas a los arrays
                        [_waiterNames addObject:waiterName];
                        [_waiterTables addObject:sortTables];
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)setupOpenedTablesBackground
{
    
    RRDataSet *dtsOpenedTables = [RRRestaurantService spGetOpenedTables:ApplicationDelegate.userPassword];
    
    /*
     NSInteger index = 0;
     for (index = 0; index <= 10000; index = index + 1) {
     NSLog(@"%d", index);
     }
     */
    
    if (dtsOpenedTables)
    {
        if ([dtsOpenedTables.tables count] > 1)
        {
            RRDataTable *tblResult = (RRDataTable*)[dtsOpenedTables.tables objectAtIndex:0];
            RRDataRow *rowResult = (RRDataRow*)[tblResult.rows objectAtIndex:0];
            NSNumber * iRes = [[NSNumber alloc] init];
            
            iRes = (NSNumber*) [rowResult getColumnByName:@"iResult"].content;
            
            if ([iRes intValue] >= 0)
            {
                [_waiterTables removeAllObjects];
                [_waiterNames removeAllObjects];
                
                RRDataTable *table = (RRDataTable*)[dtsOpenedTables.tables objectAtIndex:1];
                
                for (RRDataRow *r in table.rows)
                {
                    NSString *openedTables;
                    NSString *waiterName;
                    
                    //Obtenemos el nombre del mesero y sus mesas abiertas
                    openedTables = (NSString*)[r getColumnByName:@"TABLES"].content;
                    waiterName = (NSString*)[r getColumnByName:@"USERNAME"].content;
                    
                    //Validamos que la cadena de tablas no empiece ni termine con ','
                    if ([openedTables hasPrefix:@","])
                    {
                        openedTables = [openedTables substringFromIndex:1];
                    }
                    
                    if ([openedTables hasSuffix:@","])
                    {
                        openedTables = [openedTables substringToIndex:openedTables.length - 1];
                    }
                    
                    //Ordenamos las mesas
                    NSArray *tables = [[NSArray alloc] initWithArray:[openedTables componentsSeparatedByString:@","]];
                    NSMutableArray *sortTables;
                    
                    if ([tables count] > 1)
                    {
                        
                        sortTables = [[NSMutableArray alloc]initWithArray:
                                      [tables sortedArrayUsingComparator:
                                       ^NSComparisonResult(NSString *str1, NSString *str2)
                                       {
                                           return [str1 compare:str2 options:NSNumericSearch];
                                       }
                                       ]
                                      ];
                        
                    }
                    else
                    {
                        sortTables = (NSMutableArray *)[tables sortedArrayUsingSelector:@selector(localizedCompare:)];
                    }
                    
                    //Agregamos nombre del mesero y sus mesas abiertas a los arrays
                    [_waiterNames addObject:waiterName];
                    [_waiterTables addObject:sortTables];
                    
                }
                
            }
            
        }
        
    }
    
    //[[self collectionView] reloadData];
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}

-(void) setTheme
{
    
    [self.collectionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"leather-background.png"]]];
}

@end
