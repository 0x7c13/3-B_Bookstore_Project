//
//  OSU_proofOfPurchaseViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-3.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OSU_proofOfPurchaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateAndZIPCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditCardTypeAndNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *orderListTable;


@end
