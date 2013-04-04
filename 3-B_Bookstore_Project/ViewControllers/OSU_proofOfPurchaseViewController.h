//
//  OSU_proofOfPurchaseViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-3.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OSU_proofOfPurchaseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityStateAndZIPCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *creditCardTypeAndNumberLabel;
@property (strong, nonatomic) IBOutlet UITableView *orderListTable;


@end
