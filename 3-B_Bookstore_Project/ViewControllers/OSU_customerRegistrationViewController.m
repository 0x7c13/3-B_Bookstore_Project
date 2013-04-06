//
//  OSU_customerRegistrationViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-31.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_customerRegistrationViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_3BShoppingCart.h"
#import "URBAlertView.h"
#import "OSU_3BUser.h"

@interface OSU_customerRegistrationViewController () 

@property (strong, nonatomic) NIDropDown *creditCardDropUp;
@property (strong, nonatomic) NIDropDown *stateDropUp;

@property (strong, nonatomic) URBAlertView *alertView;
@property (strong, nonatomic) URBAlertView *alertView2;
@property (strong, nonatomic) URBAlertView *alertView3;
@property (strong, nonatomic) URBAlertView *alertView4;

@end

@implementation OSU_customerRegistrationViewController

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
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_gray.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8f;
    
    
	URBAlertView *alertView = [URBAlertView dialogWithTitle:@"Attention:" subtitle:@"In order to proceed with the payment, you need to register first."];
	alertView.blurBackground = NO;
	[alertView addButtonWithTitle:@"Exit"];
	[alertView addButtonWithTitle:@"Register"];
	[alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        // do stuff here
		[self.alertView hideWithCompletionBlock:^{
            if (buttonIndex == 0) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
		}];
	}];
	
	self.alertView = alertView;
  
    
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
    
    URBAlertView *alertView4 = [URBAlertView dialogWithTitle:@"Sorry:" subtitle:@"Username already exists!"];
	alertView4.blurBackground = NO;
	[alertView4 addButtonWithTitle:@"OK"];
	[alertView4 setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView4) {
        // do stuff here
		[self.alertView4 hideWithCompletionBlock:^{
		}];
	}];
    
    self.alertView4 = alertView4;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipRegistrationButtonPressed:(UIButton *)sender {
    
    [self.alertView showWithAnimation:URBAlertAnimationFlipHorizontal];
    
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

- (IBAction)registerButtonPressed:(UIButton *)sender {
    
    if (![self.username.text isEqualToString:@""] && ![self.PIN1.text isEqualToString:@""] &&
        ![self.PIN2.text isEqualToString:@""] && ![self.firstName.text isEqualToString:@""] &&
        ![self.lastName.text isEqualToString:@""] && ![self.address.text isEqualToString:@""] &&
        ![self.city.text isEqualToString:@""] && ![self.ZIPCode.text isEqualToString:@""] &&
        ![self.creditCardNumber.text isEqualToString:@""] && ![self.expirationDate.text isEqualToString:@""]) {
        
        if (![self.PIN1.text isEqualToString:self.PIN2.text]) {
            [self.alertView3 showWithAnimation:URBAlertAnimationDefault];
        }
        else {

            if ([[OSU_3BSQLiteDatabaseHandler sharedInstance] usernameIsInDatabase:self.username.text]) {
                [self.alertView4 showWithAnimation:URBAlertAnimationTumble];
            }
            else {
                // everything is clear
                OSU_3BUser *newUser = [[OSU_3BUser alloc]initWithUsername:self.username.text
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
                        
                [[OSU_3BSQLiteDatabaseHandler sharedInstance]insertNewUser:newUser withUserType:OSU_3BUserTypeCustomer];
                [[OSU_3BShoppingCart sharedInstance] setCurrentCustomer:newUser];
                [self performSegueWithIdentifier:@"orderListSegue2" sender:self];
            }
        }
        
    }
    else {
        [self.alertView2 showWithAnimation:URBAlertAnimationDefault];
    }
    
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

- (IBAction)userDidTapOnBackground:(UITapGestureRecognizer *)sender {
    
    [self.username resignFirstResponder];
    [self.PIN1 resignFirstResponder];
    [self.PIN2 resignFirstResponder];
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.address resignFirstResponder];
    [self.city resignFirstResponder];
    [self.ZIPCode resignFirstResponder];
    [self.creditCardNumber resignFirstResponder];
    [self.expirationDate resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
}


@end
