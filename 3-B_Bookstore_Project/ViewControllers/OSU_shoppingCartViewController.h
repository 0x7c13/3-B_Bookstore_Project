//
//  OSU_shoppingCartViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OSU_3BShoppingCart.h"
#import "OSU_3BShoppingCartCell.h"

@interface OSU_shoppingCartViewController : UIViewController <OSU_3BShoppingCartCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *shoppingCartTableView;
@property (weak, nonatomic) IBOutlet UIView *labelBG;
@property (weak, nonatomic) IBOutlet UILabel *shoppingCartInfo;
@property (weak, nonatomic) IBOutlet UIView *lowerLabelBG;
@property (weak, nonatomic) IBOutlet UILabel *subtotalInfo;

@end
