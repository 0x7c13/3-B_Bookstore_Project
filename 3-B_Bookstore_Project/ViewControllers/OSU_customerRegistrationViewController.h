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

@property (strong, nonatomic) IBOutlet UITextField *username;
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


@end
