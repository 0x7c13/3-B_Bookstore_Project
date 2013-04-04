//
//  OSU_customerProfileViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-3.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NIDropDown.h"

@interface OSU_customerProfileViewController : UIViewController <UITextFieldDelegate, NIDropDownDelegate>


@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UITextField *PIN1;
@property (strong, nonatomic) IBOutlet UITextField *PIN2;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UIButton *state;
@property (strong, nonatomic) IBOutlet UITextField *ZIPCode;
@property (strong, nonatomic) IBOutlet UIButton *creditCardType;
@property (strong, nonatomic) IBOutlet UITextField *creditCardNumber;
@property (strong, nonatomic) IBOutlet UITextField *expirationDate;



@end
