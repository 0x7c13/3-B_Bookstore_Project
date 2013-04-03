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

@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityStateAndZIPCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *creditCardTypeAndNumberLabel;

@end
