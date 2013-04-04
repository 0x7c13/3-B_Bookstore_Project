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

@end

@implementation OSU_initViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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

@end
