//
//  OSU_searchResultViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_searchResultViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OSU_3BBookCell.h"
#import "OSU_3BShoppingCart.h"

@interface OSU_searchResultViewController ()

@end

@implementation OSU_searchResultViewController

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
    [self updateResultsInfo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Progress Hud view

    if (self.resultBooks.count == 0) {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        HUD.delegate = self;
        HUD.dimBackground = YES;
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"No matching items found!";
        HUD.margin = 10.f;
        //HUD.yOffset = 150.f;
        HUD.removeFromSuperViewOnHide = YES;
	
        [HUD hide:YES afterDelay:1.0f];
    }
    else {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        HUD.userInteractionEnabled = NO;
        HUD.delegate = self;
        HUD.dimBackground = NO;
        HUD.mode = MBProgressHUDModeText;
        if (self.resultBooks.count == 1) {
            HUD.labelText = [NSString stringWithFormat:@"Found %u result to your search", self.resultBooks.count];
        }
        else {
            HUD.labelText = [NSString stringWithFormat:@"Found %u results to your search", self.resultBooks.count];
        }
        HUD.margin = 10.f;
        HUD.yOffset = 150.f;
        HUD.removeFromSuperViewOnHide = YES;
        
        [HUD hide:YES afterDelay:1.2f];
    }
    
    if ([[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart] > 1) {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u items", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    else {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u item", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8f;

    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    
    [buttonLeft setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    [self addShadow:(UIImageView *)self.labelBG];
}

- (void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addShadow: (UIImageView *)view
{
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowOffset:CGSizeMake(0.0f, 10.0f)];
    [view.layer setShadowOpacity:0.4];
    [view.layer setShadowRadius:6.0];
    
    // improve performance
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.shadowPath = path.CGPath;
}

- (void)updateResultsInfo
{
    if ([[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart] > 1) {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u items", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    else {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u item", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    
    [self.resultTable reloadData];

}


// protocols ***********************************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultBooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSU_3BBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell"];

    cell.delegate = self;
    cell.book = [self.resultBooks objectAtIndexedSubscript:indexPath.row];
    cell.bookTitle.text = cell.book.Titile;
    cell.bookAuthor.text = cell.book.Author;
    cell.bookPublisher.text = cell.book.Publisher;
    cell.bookISBN.text = cell.book.ISBN;
    cell.bookPrice.text = [NSString stringWithFormat:@"$ %.2f",cell.book.Price];
    
    if (![[OSU_3BShoppingCart sharedInstance] isInShoppingCart:cell.book]) {
        cell.addToCartButton.userInteractionEnabled = YES;
        [cell.addToCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.checkMark.alpha = 0.0;
    }
    else {
        cell.addToCartButton.userInteractionEnabled = NO;
        [cell.addToCartButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.checkMark.alpha = 1.0;
    }
    
    return cell;
}



- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.yOffset != 150.f) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)userDidPressAddToCartButton:(OSU_3BBookCell *)cell
{
    if ([[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart] > 1) {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u items", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    else {
        self.shoppingCartInfo.text = [NSString stringWithFormat:@"Your Shopping Cart has %u item", [[OSU_3BShoppingCart sharedInstance]numberOfDistinctItemsInShoppingCart]];
    }
    
    if ([[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue == nil) {
        [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = @"1";
    }
    else {
        int tmp = [[[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue integerValue] + 1;
        [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d", tmp];
    }

}

- (void)userDidPressReviewsButton:(OSU_3BBookCell *)cell
{


}

@end
