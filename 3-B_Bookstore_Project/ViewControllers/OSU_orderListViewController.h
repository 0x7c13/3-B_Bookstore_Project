//
//  OSU_orderListViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-2.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OSU_3BBook.h"

@interface OSU_orderListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateAndZIPCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditCardTypeAndNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *orderListTable;

@end
