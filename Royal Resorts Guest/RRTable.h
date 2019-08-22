//
//  RRTable.h
//  iRest
//
//  Created by Ernesto Fuentes de Maria Alvarez on 8/28/13.
//  Copyright (c) 2013 Royal Resorts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRTable : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgPicture;
@property (strong,nonatomic) NSString *strTableNo;

@end
