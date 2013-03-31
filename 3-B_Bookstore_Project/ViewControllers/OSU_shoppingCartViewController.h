//
//  OSU_shoppingCartViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OSU_3BShoppingCart.h"
#import "OSU_3BShoppingCartCell.h"

@interface OSU_shoppingCartViewController : UIViewController <OSU_3BShoppingCartCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *shoppingCartTableView;
@property (strong, nonatomic) IBOutlet UIView *labelBG;
@property (strong, nonatomic) IBOutlet UILabel *shoppingCartInfo;
@property (strong, nonatomic) IBOutlet UIView *lowerLabelBG;
@property (strong, nonatomic) IBOutlet UILabel *subtotalInfo;

@end
