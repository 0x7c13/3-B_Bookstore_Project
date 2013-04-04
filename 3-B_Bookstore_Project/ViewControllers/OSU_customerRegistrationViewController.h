//
//  OSU_customerRegistrationViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-31.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NIDropDown.h"

@interface OSU_customerRegistrationViewController : UIViewController <UITextFieldDelegate, NIDropDownDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *PIN1;
@property (weak, nonatomic) IBOutlet UITextField *PIN2;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UIButton *state;
@property (weak, nonatomic) IBOutlet UITextField *ZIPCode;
@property (weak, nonatomic) IBOutlet UIButton *creditCardType;
@property (weak, nonatomic) IBOutlet UITextField *creditCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *expirationDate;


@end
