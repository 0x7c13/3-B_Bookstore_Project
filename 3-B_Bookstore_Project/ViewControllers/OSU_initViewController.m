//
//  OSUViewController.m
//  3-B_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_initViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_3BBook.h"
#import "OSU_3BShoppingCart.h"


@interface OSU_initViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation OSU_initViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.popupView.layer.cornerRadius = 12;
    self.popupView.layer.shadowOpacity = 0.7;
    self.popupView.layer.shadowOffset = CGSizeMake(6, 6);
    self.popupView.layer.shouldRasterize = YES;
    self.popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"startRegistrationSegue"]) {
        OSU_newCustomerViewController *registrationVC = segue.destinationViewController;
        registrationVC.delegate = self;
    }
}

- (IBAction)searchOnlyButtonPressed:(UIButton *)sender {
    
    [[OSU_3BShoppingCart sharedInstance] initShoppingCart];
    [self performSegueWithIdentifier:@"searchOnlySegue" sender:self];
    
}

- (IBAction)newCustomerButtonPressed:(UIButton *)sender {

    [[OSU_3BShoppingCart sharedInstance] initShoppingCart];
    [self performSegueWithIdentifier:@"startRegistrationSegue" sender:self];
}

- (void)registrationDidFinished
{
    [self performSegueWithIdentifier:@"searchOnlySegue" sender:self];
}

- (IBAction)returningCustomerButtonPressed:(UIButton *)sender {
    
    UIColor *color = nil;
    [ASDepthModalViewController presentView:self.popupView withBackgroundColor:color popupAnimationStyle:ASDepthModalAnimationDefault];
    
    
    
}
- (IBAction)usernameFieldTouchDown:(UITextField *)sender {
    
    [sender resignFirstResponder];
}


- (IBAction)passwordFieldTouchDown:(UITextField *)sender {
    
    [sender resignFirstResponder];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    if ([self loginCheck]) {
        [ASDepthModalViewController dismiss];
        [NSTimer scheduledTimerWithTimeInterval: 0.4f target:self selector:@selector(GoSearch:) userInfo:nil repeats: NO];
    }
    else {
        // shake
        [self shakeWithDuration:0.1f];
    }
}


- (BOOL)loginCheck
{
    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
        
        if ([[OSU_3BSQLiteDatabaseHandler sharedInstance] usernameIsExist:self.usernameTextField.text]) {
            
            OSU_3BUser *returningCusotmer = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectUserFromDatabaseWithUsername:self.usernameTextField.text];
            if ([returningCusotmer.PIN isEqualToString:self.passwordTextField.text]) {
                [[OSU_3BShoppingCart sharedInstance] setCurrentCustomer:returningCusotmer];
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([self loginCheck]) {
        [ASDepthModalViewController dismiss];
        [NSTimer scheduledTimerWithTimeInterval: 0.4f target:self selector:@selector(GoSearch:) userInfo:nil repeats: NO];
    }
    else {
        // shake
        [self shakeWithDuration:0.1f];
    }

    return YES;
}

- (void)GoSearch:(NSTimer *)timer
{
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    [self performSegueWithIdentifier:@"searchOnlySegue" sender:self];
    [timer invalidate];
}

- (void)shakeWithDuration:(NSTimeInterval)animationTime
{
    CGFloat t = 4.0;
    
    CGAffineTransform leftQuake  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0);
    CGAffineTransform rightQuake = CGAffineTransformTranslate(CGAffineTransformIdentity,-t, 0);
    
    self.popupView.transform = leftQuake;  // starting point
    
    [UIView beginAnimations:@"earthquake" context:nil];
    [UIView setAnimationRepeatAutoreverses:YES];    // important
    [UIView setAnimationRepeatCount:2];
    [UIView setAnimationDuration:animationTime];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(earthquakeEnded:finished:context:)];
    
    self.popupView.transform = rightQuake;    // end here & auto-reverse
    
    [UIView commitAnimations];
}


@end
