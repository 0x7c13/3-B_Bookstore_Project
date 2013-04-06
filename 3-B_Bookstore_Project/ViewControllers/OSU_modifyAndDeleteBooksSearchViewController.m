//
//  OSU_modifyAndDeleteBooksSearchViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-5.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_modifyAndDeleteBooksSearchViewController.h"
#import "OSU_modifyAndDeleteBooksSearchResultsViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"

@interface OSU_modifyAndDeleteBooksSearchViewController () {
    
    NSArray *titleOfRows;
    NSInteger indexOfRow;
    
    NSArray *titleOfCategories;
    NSInteger indexOfCategory;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (strong, nonatomic) AFPickerView *databaseRowPicker;
@property (strong, nonatomic) AFPickerView *categoryPicker;

@end


@implementation OSU_modifyAndDeleteBooksSearchViewController


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
    
    [self addPickers];
    
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    
    [buttonLeft setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    
    
}

- (void)addPickers;
{
    titleOfRows = @[@"Keyword Anywhere", @"ISBN", @"Title", @"Author", @"Publisher"];
    
    titleOfCategories = [[NSArray alloc] initWithObjects:@"All Categories", nil];
    titleOfCategories = [titleOfCategories arrayByAddingObjectsFromArray:[[OSU_3BSQLiteDatabaseHandler sharedInstance] getCategoriesFromDatabase]];
    
    self.databaseRowPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(0.0, 65.0, 320.0, 197.0)];
    self.databaseRowPicker.dataSource = self;
    self.databaseRowPicker.delegate = self;
    self.databaseRowPicker.rowFont = [UIFont boldSystemFontOfSize:15.0];
    self.databaseRowPicker.rowIndent = 20.0;
    [self.databaseRowPicker reloadData];
    [self.view addSubview:self.databaseRowPicker];
    
    self.categoryPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(0.0, 280.0, 320.0, 197.0)];
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
    OSU_modifyAndDeleteBooksSearchResultsViewController *resultVC = segue.destinationViewController;
    resultVC.resultBooks = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectBooksFromDatabaseWithKeyword:self.searchField.text
                                                                                                   Category:titleOfCategories[indexOfCategory]
                                                                                                    RowName:titleOfRows[indexOfRow]];
    
}

- (void)GoBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self performSegueWithIdentifier:@"pushAdminSearchResultsSegue" sender:self];
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
