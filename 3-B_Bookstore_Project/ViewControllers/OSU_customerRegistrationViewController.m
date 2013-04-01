//
//  OSU_customerRegistrationViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-31.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_customerRegistrationViewController.h"
#import "URBAlertView.h"

@interface OSU_customerRegistrationViewController ()
@property (nonatomic, strong) URBAlertView *alertView;
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

-(void)viewDidAppear:(BOOL)animated
{
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
    
    
    /*
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    
    [buttonLeft setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(Exit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
     */
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipRegistrationButtonPressed:(UIButton *)sender {
    
    [self.alertView showWithAnimation:URBAlertAnimationFlipHorizontal];
    
}




@end
