//
//  OSU_manageBookstoreCatalogViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-5.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_manageBookstoreCatalogViewController.h"

@interface OSU_manageBookstoreCatalogViewController ()

@end

@implementation OSU_manageBookstoreCatalogViewController

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
    
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    
    [buttonLeft setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)insertNewBookButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"pushInsertNewBookSegue" sender:self];

}


@end
