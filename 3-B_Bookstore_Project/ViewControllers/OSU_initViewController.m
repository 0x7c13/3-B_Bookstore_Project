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
#import "KGStatusBar.h"


@interface OSU_initViewController () {
    OSU_3BUserUserTypes _currentUserType;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) ASDepthModalViewController *popManagerVC;

@end

@implementation OSU_initViewController


- (ASDepthModalViewController *)popManagerVC
{
    if (!_popManagerVC) {
        _popManagerVC = [[ASDepthModalViewController alloc]init];
        _popManagerVC.delegate = self;
    }
    return _popManagerVC;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.popupView.layer.cornerRadius = 12;
    self.popupView.layer.shadowOpacity = 0.7;
    self.popupView.layer.shadowOffset = CGSizeMake(6, 6);
    self.popupView.layer.shouldRasterize = YES;
    self.popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    _currentUserType = OSU_3BUserTypeCustomer;
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
    
    _currentUserType = OSU_3BUserTypeCustomer;
    [[OSU_3BShoppingCart sharedInstance] initShoppingCart];
    [self performSegueWithIdentifier:@"searchOnlySegue" sender:self];
    
}

- (IBAction)newCustomerButtonPressed:(UIButton *)sender {

    _currentUserType = OSU_3BUserTypeCustomer;
    [[OSU_3BShoppingCart sharedInstance] initShoppingCart];
    [self performSegueWithIdentifier:@"startRegistrationSegue" sender:self];
}

- (void)registrationDidFinished
{
    [KGStatusBar showSuccessWithStatus:@"Login successfully"];
    [self performSegueWithIdentifier:@"searchOnlySegue" sender:self];
}

- (IBAction)returningCustomerButtonPressed:(UIButton *)sender {
    
    _currentUserType = OSU_3BUserTypeCustomer;
    [self.popManagerVC presentView:self.popupView withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationDefault];
}


- (IBAction)administratorButtonPressed:(UIButton *)sender {
    
    _currentUserType = OSU_3BUserTypeAdministrator;
    [self.popManagerVC presentView:self.popupView withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationDefault];
}


- (IBAction)usernameFieldTouchDown:(UITextField *)sender {
    
    [sender resignFirstResponder];
}


- (IBAction)passwordFieldTouchDown:(UITextField *)sender {
    
    [sender resignFirstResponder];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    if ([self loginCheck]) {
        [self.popManagerVC dismiss];
    }
    else {
        // shake
        [self shakeWithDuration:0.1f];
    }
}


- (BOOL)loginCheck
{
    if (_currentUserType == OSU_3BUserTypeCustomer) {
        if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
            
            if ([[OSU_3BSQLiteDatabaseHandler sharedInstance] usernameIsExist:self.usernameTextField.text]) {
                
                OSU_3BUser *returningCusotmer = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectUserFromDatabaseWithUsername:self.usernameTextField.text];
                if ([returningCusotmer.PIN isEqualToString:self.passwordTextField.text]) {
                    [[OSU_3BShoppingCart sharedInstance] setCurrentCustomer:returningCusotmer];
                    [KGStatusBar showSuccessWithStatus:@"Login successfully"];
                    return YES;
                }
                else {
                    [KGStatusBar showErrorWithStatus:@"Wrong password!"];
                }
            }
            else {
                [KGStatusBar showErrorWithStatus:@"Username doesn't exist!"];
            }
        }
    }
    else if (_currentUserType == OSU_3BUserTypeAdministrator) {
        if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {

            if ([self.passwordTextField.text isEqualToString:@"admin"] && [self.usernameTextField.text isEqualToString:@"admin"]) {
                [KGStatusBar showSuccessWithStatus:@"Login successfully"];
                return YES;
            }
            else {
                [KGStatusBar showErrorWithStatus:@"Wrong admin username or password!"];
            }
        }
    }
    return NO;
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    if ([self loginCheck]) {
        [self.popManagerVC dismiss];
    }
    else {
        // shake
        [self shakeWithDuration:0.1f];
    }
    
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.20f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.popupView.frame.size.width, self.popupView.frame.size.height);
    self.popupView.frame = rect;
    [UIView commitAnimations];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.20f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.popupView.frame.size.width, self.popupView.frame.size.height);
    self.popupView.frame = rect;
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int offset = 30.0f;
    NSTimeInterval animationDuration = 0.20f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.popupView.frame.size.width;
    float height = self.popupView.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.popupView.frame = rect;
    }
    [UIView commitAnimations];
}


#pragma -- protocal

- (void)popupViewDidDisappear:(ASDepthModalViewController *)sender
{
    self.view.userInteractionEnabled = NO;
    
    if (_currentUserType == OSU_3BUserTypeCustomer) {
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(GoSearch:) userInfo:nil repeats:NO];
    }
    else if (_currentUserType == OSU_3BUserTypeAdministrator){
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(GoAdmin:) userInfo:nil repeats:NO];
    }
}

- (void)GoSearch:(NSTimer *)timer
{
    [self performSegueWithIdentifier:@"searchOnlySegue" sender:self];
    self.view.userInteractionEnabled = YES;
    [timer invalidate];
}

- (void)GoAdmin:(NSTimer *)timer
{
    [self performSegueWithIdentifier:@"adminEntrySegue" sender:self];
    self.view.userInteractionEnabled = YES;
    [timer invalidate];
}

- (void)userDidDismissPopupView:(ASDepthModalViewController *)sender
{
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";

}

@end
