//
//  OSU_modifyAndDeleteBooksSearchResultsViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_modifyAndDeleteBooksSearchResultsViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "KGStatusBar.h"
#import "OSU_updateBookViewController.h"

@interface OSU_modifyAndDeleteBooksSearchResultsViewController () {
    int _updatedRow;
}

@property (weak, nonatomic) IBOutlet UIImageView *lowerBG;
@property (strong, nonatomic) NSMutableArray *pendingBooks;
@property (strong, nonatomic) OSU_3BBook *objBook;
@property (nonatomic) BOOL updated;

@end

@implementation OSU_modifyAndDeleteBooksSearchResultsViewController

- (NSMutableArray *)pendingBooks
{
    if (!_pendingBooks) {
        _pendingBooks = [[NSMutableArray alloc] init];
    }
    return _pendingBooks;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated    
{
    [super viewWillAppear:animated];
    
    if (self.updated) {
        
        OSU_3BBook *targetBook = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectABookFromDatabaseWithISBN:[self.resultBooks objectAtIndexedSubscript:_updatedRow].ISBN];
        
        [self.resultBooks removeABook:[self.resultBooks objectAtIndexedSubscript:_updatedRow]];
        
        [self.resultBooks addABook:targetBook];
        
        [self.resultTable reloadData];
        
        self.updated = NO;
    }
    
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
    
    // add back button
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    
    [buttonLeft setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    // set table view background image
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_bg.png"]];
    [tempImageView setFrame:self.resultTable.frame];
    self.resultTable.backgroundView = tempImageView;
    
    // add shadow to label background image
    [self addShadow:(UIImageView *)self.lowerBG towardsUp:YES];
    
    self.updated = NO;
}

- (void)GoBack
{
    [self.pendingBooks removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)doneButtonPressed:(UIButton *)sender {
    
    for (OSU_3BBook *pendingBook in self.pendingBooks) {
        [[OSU_3BSQLiteDatabaseHandler sharedInstance] deleteABookByISBN:pendingBook.ISBN];
    }
    [self.pendingBooks removeAllObjects];
    
    [KGStatusBar showSuccessWithStatus:@"Delete Successfully"];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancelButtonPressed:(UIButton *)sender {

    [self.pendingBooks removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma -- protocols ***********************************************

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
    OSU_3BModifyAndDeleteBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdminBookCell"];
    
    cell.delegate = self;
    cell.book = [self.resultBooks objectAtIndexedSubscript:indexPath.row];
    cell.bookTitle.text = cell.book.Titile;
    cell.bookAuthor.text = cell.book.Author;
    cell.bookPublisher.text = cell.book.Publisher;
    cell.bookPrice.text = [NSString stringWithFormat:@"$ %.2f",cell.book.Price];
    cell.deletedLabel.alpha = 0.0f;

    
    if (![self.pendingBooks containsObject:cell.book]) {
        cell.deleteButton.userInteractionEnabled = YES;
        [cell.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.updateButton.userInteractionEnabled = YES;
        [cell.updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        cell.deletedLabel.alpha = 0.0;
    }
    else {
        cell.deleteButton.userInteractionEnabled = NO;
        [cell.deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.updateButton.userInteractionEnabled = NO;
        [cell.updateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.deletedLabel.alpha = 1.0;
    }
    
    return cell;
}



- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.yOffset != 150.f) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)userDidPressUpdateButton:(OSU_3BModifyAndDeleteBookCell *)cell
{
    self.objBook = cell.book;
    self.updated = YES;
    _updatedRow = [self.resultTable indexPathForCell:cell].row;
    [self performSegueWithIdentifier:@"pushUpdateBookSegue" sender:self];
}

- (void)userDidPressDeleteButton:(OSU_3BModifyAndDeleteBookCell *)cell
{
    [self.pendingBooks addObject:cell.book];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OSU_updateBookViewController *updateVC = segue.destinationViewController;
    
    updateVC.currentBook = self.objBook;

}


@end
