//
//  OSU_searchViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_searchViewController.h"
#import "OSU_3BShoppingCart.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_searchResultViewController.h"
#import "KGModal.h"

@interface OSU_searchViewController () {
    
    NSArray *titleOfRows;
    NSInteger indexOfRow;
    
    NSArray *titleOfCategories;
    NSInteger indexOfCategory;
    
    BOOL firstLoad;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (strong, nonatomic) AFPickerView *databaseRowPicker;
@property (strong, nonatomic) AFPickerView *categoryPicker;

@end

@implementation OSU_searchViewController

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
    [super viewDidAppear:animated];

    if (firstLoad && ![[OSU_3BShoppingCart sharedInstance] isGuestMode]) {
        
        OSU_3BUser *currentUser = [[OSU_3BShoppingCart sharedInstance] getCurrentCustomer];

        if (![currentUser.smartCategory isEqualToString:@""] ) {

            BOOL existAtLeastOne = NO;
            
            OSU_3BBooks *suggestedBooks = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectBooksFromDatabaseBySmartCategory:currentUser.smartCategory];
            
            for (int i = 0; i < [suggestedBooks count]; i++) {
                [[OSU_3BShoppingCart sharedInstance] addItem:[suggestedBooks objectAtIndexedSubscript:i] withQuantity:1];
                existAtLeastOne = YES;
            }
            
            if (existAtLeastOne) {
                UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 180)];
                
                CGRect welcomeLabelRect = contentView.bounds;
                welcomeLabelRect.origin.y = 20;
                welcomeLabelRect.size.height = 20;
                UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
                UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
                welcomeLabel.text = @"Welcome Back!";
                welcomeLabel.font = welcomeLabelFont;
                welcomeLabel.textColor = [UIColor whiteColor];
                welcomeLabel.textAlignment = NSTextAlignmentCenter;
                welcomeLabel.backgroundColor = [UIColor clearColor];
                welcomeLabel.shadowColor = [UIColor blackColor];
                welcomeLabel.shadowOffset = CGSizeMake(0, 1);
                [contentView addSubview:welcomeLabel];
                
                CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
                infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
                infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
                UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
                infoLabel.text = @"A list of suggested books has generated for you. Go to your shopping cart and have a look. Hope you like it!";
                infoLabel.numberOfLines = 6;
                infoLabel.textColor = [UIColor whiteColor];
                infoLabel.textAlignment = NSTextAlignmentCenter;
                infoLabel.backgroundColor = [UIColor clearColor];
                infoLabel.shadowColor = [UIColor blackColor];
                infoLabel.shadowOffset = CGSizeMake(0, 1);
                [contentView addSubview:infoLabel];
                
                [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
            }
            
            currentUser.smartCategory = @"";
            [[OSU_3BShoppingCart sharedInstance]setCurrentCustomer:currentUser];
            
        }
        
        firstLoad = NO;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addPickers];
    
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

    firstLoad = YES;
}

- (void)addPickers;
{
    titleOfRows = @[@"Keyword Anywhere", @"ISBN", @"Title", @"Author", @"Publisher"];
    
    titleOfCategories = [[NSArray alloc] initWithObjects:@"All Categories", nil];
    titleOfCategories = [titleOfCategories arrayByAddingObjectsFromArray:[[OSU_3BSQLiteDatabaseHandler sharedInstance] getCategoriesFromDatabase]];
    
    self.databaseRowPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(0.0, 48.0, 320.0, 197.0)];
    self.databaseRowPicker.dataSource = self;
    self.databaseRowPicker.delegate = self;
    self.databaseRowPicker.rowFont = [UIFont boldSystemFontOfSize:15.0];
    self.databaseRowPicker.rowIndent = 20.0;
    [self.databaseRowPicker reloadData];
    [self.view addSubview:self.databaseRowPicker];
    
    self.categoryPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(0.0, 253.0, 320.0, 197.0)];
    self.categoryPicker.dataSource = self;
    self.categoryPicker.delegate = self;
    self.categoryPicker.rowFont = [UIFont boldSystemFontOfSize:15.0];
    self.categoryPicker.rowIndent = 20.0;
    [self.categoryPicker reloadData];
    [self.view addSubview:self.categoryPicker];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OSU_searchResultViewController *resultVC = segue.destinationViewController;
    resultVC.resultBooks = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectBooksFromDatabaseByKeyword:self.searchField.text
                                                                                                   Category:titleOfCategories[indexOfCategory]
                                                                                                    RowName:titleOfRows[indexOfRow]];

}



- (void)Exit
{
    [[OSU_3BShoppingCart sharedInstance] cleanShoppingCart];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// protocols ********************


#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (pickerView == self.databaseRowPicker)
        return titleOfRows.count;
    else {
        return titleOfCategories.count;
    }
}


- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == self.databaseRowPicker)
        return [titleOfRows objectAtIndex:row];
    else {
        return [titleOfCategories objectAtIndex:row];
    }
}


#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView == self.databaseRowPicker) {
        indexOfRow = row;
    }
    else{
        indexOfCategory = row;
    }
}


#pragma - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"pushSearchResultSegue" sender:self];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; 
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {

    [searchBar resignFirstResponder]; 
}


@end
