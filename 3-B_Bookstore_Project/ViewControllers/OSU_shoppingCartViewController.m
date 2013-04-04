//
//  OSU_shoppingCartViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_shoppingCartViewController.h"
#import "URBAlertView.h"

@interface OSU_shoppingCartViewController ()
@property (nonatomic, strong) URBAlertView *alertView;
@end

@implementation OSU_shoppingCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
    [self.shoppingCartTableView reloadData];
    [self updateShoppingCartInfo];

    
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
    
    
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    
    [buttonLeft setImage:[UIImage imageNamed:@"ExitButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(Exit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    self.shoppingCartTableView.delegate = self;
    self.shoppingCartTableView.dataSource = self;
    
    [self addShadow:(UIImageView *)self.labelBG towardsUp:NO];
    [self addShadow:(UIImageView *)self.lowerLabelBG towardsUp:YES];
    
    [self updateShoppingCartInfo];
    
    URBAlertView *alertView = [URBAlertView dialogWithTitle:@"Attention:" subtitle:@"The shopping cart is empty!"];
	alertView.blurBackground = NO;
	[alertView addButtonWithTitle:@"OK"];
	[alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
		[self.alertView hideWithCompletionBlock:^{
		}];
	}];
	
	self.alertView = alertView;
    
    // set table view background image
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_bg.png"]];
    [tempImageView setFrame:self.shoppingCartTableView.frame];
    self.shoppingCartTableView.backgroundView = tempImageView;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addShadow: (UIImageView *)view towardsUp:(BOOL)towardsUp
{
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    if (towardsUp) {
        [view.layer setShadowOffset:CGSizeMake(0.0f, -10.0f)];
    }
    else {
        [view.layer setShadowOffset:CGSizeMake(0.0f, 10.0f)];
    }
    [view.layer setShadowOpacity:0.4];
    [view.layer setShadowRadius:6.0];
    
    // improve performance
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.shadowPath = path.CGPath;
}

- (void)updateShoppingCartInfo
{
    if ([[OSU_3BShoppingCart sharedInstance]numberOfItemsInShoppingCart] > 1) {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u items", [[OSU_3BShoppingCart sharedInstance]numberOfItemsInShoppingCart]];
    }
    else {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u item", [[OSU_3BShoppingCart sharedInstance]numberOfItemsInShoppingCart]];
    }
    
    self.subtotalInfo.text = [NSString stringWithFormat:@"Subtotal:  $ %.2lf", [[OSU_3BShoppingCart sharedInstance] subtotalValue]];
}



- (IBAction)checkoutButtonPressed:(UIButton *)sender {

    if ([[OSU_3BShoppingCart sharedInstance] numberOfDistinctItemsInShoppingCart] > 0) {
        if ([[OSU_3BShoppingCart sharedInstance] isGuestMode]) {
            [self performSegueWithIdentifier:@"checkoutSegue" sender:self];
        }
        else {
            [self performSegueWithIdentifier:@"orderListSegue" sender:self];
        }
    }
    else {
        [self.alertView showWithAnimation:URBAlertAnimationSlideLeft];
    }
    
}

- (void)Exit
{
    [[OSU_3BShoppingCart sharedInstance] cleanShoppingCart];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[OSU_3BShoppingCart sharedInstance] numberOfDistinctItemsInShoppingCart];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSU_3BShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell"];
    
    cell.delegate = self;
    cell.book = [[OSU_3BShoppingCart sharedInstance]objectAtIndexedSubscript:indexPath.row];
    cell.bookTitle.text = cell.book.Titile;
    cell.bookAuthor.text = cell.book.Author;
    cell.bookPrice.text = [NSString stringWithFormat:@"$ %.2f",cell.book.Price];
    cell.quantityStepper.value = (double)cell.book.Quantity;
    cell.bookQuantity.text = [NSString stringWithFormat:@"%u", (NSUInteger)cell.quantityStepper.value];
    
    return cell;
}

- (void)userDidPressDeleteButton:(OSU_3BShoppingCartCell *)cell
{
    [[OSU_3BShoppingCart sharedInstance] removeItem:cell.book];
    
    NSArray *deleteIndexPaths = [[NSArray alloc] initWithObjects:[self.shoppingCartTableView indexPathForCell:cell],
                                 nil];
    [self.shoppingCartTableView beginUpdates];
    [self.shoppingCartTableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.shoppingCartTableView endUpdates];
    
    [self updateShoppingCartInfo];
}

- (void)userDidPressStepper:(OSU_3BShoppingCartCell *)cell
{
    [self updateShoppingCartInfo];
}

@end
