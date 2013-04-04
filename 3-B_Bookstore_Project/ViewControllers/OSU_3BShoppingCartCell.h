//
//  OSU_3BShoppingCartCell.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-31.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSU_3BBook.h"


@protocol OSU_3BShoppingCartCellDelegate;


@interface OSU_3BShoppingCartCell : UITableViewCell


@property (strong, nonatomic) OSU_3BBook *book;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookPrice;
@property (weak, nonatomic) IBOutlet UILabel *bookQuantity;

@property (weak, nonatomic) IBOutlet UIStepper *quantityStepper;

@property (weak, nonatomic) id<OSU_3BShoppingCartCellDelegate> delegate;

@end


@protocol OSU_3BShoppingCartCellDelegate <NSObject>

- (void)userDidPressDeleteButton:(OSU_3BShoppingCartCell *)cell;
- (void)userDidPressStepper:(OSU_3BShoppingCartCell *)cell;

@end