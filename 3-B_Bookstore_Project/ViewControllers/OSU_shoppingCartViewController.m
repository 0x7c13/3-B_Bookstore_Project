//
//  OSU_shoppingCartViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_shoppingCartViewController.h"

@interface OSU_shoppingCartViewController ()

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
    
    self.shoppingCartTableView.delegate = self;
    self.shoppingCartTableView.dataSource = self;
    
    [self addShadow:(UIImageView *)self.labelBG towardsUp:NO];
    [self addShadow:(UIImageView *)self.lowerLabelBG towardsUp:YES];
    
    [self updateShoppingCartInfo];

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
    if ([[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart] > 1) {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u items", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    else {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u item", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    
    self.subtotalInfo.text = [NSString stringWithFormat:@"Subtotal:  $ %.2lf", [[OSU_3BShoppingCart sharedInstance] subtotalValue]];
}


// protocols ***********************************************

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
