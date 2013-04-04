//
//  OSU_customerProfileViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-3.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_customerProfileViewController.h"
#import "URBAlertView.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_3BShoppingCart.h"
#import "OSU_3BUser.h"

@interface OSU_customerProfileViewController ()

@property (strong, nonatomic) OSU_3BUser *currentUser;
@property (strong, nonatomic) NIDropDown *creditCardDropUp;
@property (strong, nonatomic) NIDropDown *stateDropUp;

@property (nonatomic, strong) URBAlertView *alertView2;
@property (nonatomic, strong) URBAlertView *alertView3;

@end

@implementation OSU_customerProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.navigationItem.hidesBackButton = YES;
    
    self.currentUser = [[OSU_3BShoppingCart sharedInstance]getCurrentCustomer];
    
    self.username.text = self.currentUser.username;
    
    URBAlertView *alertView2 = [URBAlertView dialogWithTitle:@"Attention:" subtitle:@"Please fill out all fields!"];
	alertView2.blurBackground = NO;
	[alertView2 addButtonWithTitle:@"OK"];
	[alertView2 setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView2) {
        // do stuff here
		[self.alertView2 hideWithCompletionBlock:^{
		}];
	}];
    
    self.alertView2 = alertView2;
    
    
    URBAlertView *alertView3 = [URBAlertView dialogWithTitle:@"Attention:" subtitle:@"PINs don't match!"];
	alertView3.blurBackground = NO;
	[alertView3 addButtonWithTitle:@"OK"];
	[alertView3 setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView3) {
        // do stuff here
		[self.alertView3 hideWithCompletionBlock:^{
		}];
	}];
    
    self.alertView3 = alertView3;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)creditCardTypeButtonPressed:(UIButton *)sender {
    
    if(_creditCardDropUp == nil) {
        NSArray *arr = [[NSArray alloc] init];
        arr = [NSArray arrayWithObjects:@"VISA", @"American Express", @"Diners Club", @"Discover", @"MasterCard",nil];
        
        CGFloat f = 200;
        _creditCardDropUp = [[NIDropDown alloc]initDropDown:sender Height:&f Array:arr Direction:@"up"];
        _creditCardDropUp.delegate = self;
        _creditCardDropUp.identifier = @"creditCardDropUp";
    }
    else {
        [self.creditCardDropUp hideDropDown:sender];
        self.creditCardDropUp = nil;
    }
}



- (IBAction)stateSelectButtonPressed:(UIButton *)sender {
    
    if(_stateDropUp == nil) {
        NSArray *arr = [[NSArray alloc] init];
        arr = [NSArray arrayWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"DC",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY",nil];
        
        CGFloat f = 200;
        _stateDropUp = [[NIDropDown alloc]initDropDown:sender Height:&f Array:arr Direction:@"up"];
        _stateDropUp.delegate = self;
        _stateDropUp.identifier = @"stateDropUp";
    }
    else {
        [self.stateDropUp hideDropDown:sender];
        self.stateDropUp = nil;
    }
}

- (IBAction)ZIPCodeTouchDown:(UITextField *)sender {
    [self textFieldShouldReturn:sender];
}

- (IBAction)creditCardNumberTouchDown:(UITextField *)sender {
    [self textFieldShouldReturn:sender];
}

- (IBAction)creditCardExpirationDateTouchDown:(UITextField *)sender {
    [self textFieldShouldReturn:sender];
}


- (IBAction)updateButtonPressed:(UIButton *)sender {

    if (![self.PIN1.text isEqualToString:@""] && ![self.PIN2.text isEqualToString:@""] &&
        ![self.firstName.text isEqualToString:@""] && ![self.lastName.text isEqualToString:@""] &&
        ![self.address.text isEqualToString:@""] && ![self.city.text isEqualToString:@""] &&
        ![self.ZIPCode.text isEqualToString:@""] && ![self.creditCardNumber.text isEqualToString:@""] &&
        ![self.expirationDate.text isEqualToString:@""]) {
        
        if (![self.PIN1.text isEqualToString:self.PIN2.text]) {
            [self.alertView3 showWithAnimation:URBAlertAnimationDefault];
        }
        else {
            
            // everything is clear
            OSU_3BUser *newUser = [[OSU_3BUser alloc]initWithUsername:self.currentUser.username
                                                                      PIN:self.PIN1.text
                                                                firstName:self.firstName.text
                                                                 lastName:self.lastName.text
                                                                  address:self.address.text
                                                                     city:self.city.text
                                                                    state:self.state.titleLabel.text
                                                                  ZIPCode:(NSUInteger)[self.ZIPCode.text integerValue]
                                                           creditCardType:self.creditCardType.titleLabel.text
                                                         creditCardNumber:self.creditCardNumber.text
                                                 creditCardExpirationDate:self.expirationDate.text];
                
            [[OSU_3BSQLiteDatabaseHandler sharedInstance]updateUser:newUser withUserType:OSU_3BUserTypeCustomer];
            [[OSU_3BShoppingCart sharedInstance] setCurrentCustomer:newUser];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else {
        [self.alertView2 showWithAnimation:URBAlertAnimationDefault];
    }
    
}
- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma protocols

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    if ([sender.identifier isEqualToString:@"creditCardDropUp"]) {
        self.creditCardDropUp = nil;
    }
    else {
        self.stateDropUp = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}


@end
