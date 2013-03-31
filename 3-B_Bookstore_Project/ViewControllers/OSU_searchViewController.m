//
//  OSU_searchViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_searchViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_searchResultViewController.h"

@interface OSU_searchViewController () {
    
    NSArray *titleOfRows;
    NSInteger indexOfRow;
    
    NSArray *titleOfCategories;
    NSInteger indexOfCategory;
}

@property (strong, nonatomic) IBOutlet UITextField *searchField;
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
    
    [buttonLeft setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(Exit) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];

    self.navigationItem.leftBarButtonItem = itemLeft;

    

}

- (void)addPickers;
{
    titleOfRows = [NSArray arrayWithObjects:@"Keyword Anywhere", @"ISBN", @"Title", @"Author", @"Publisher", nil];
    
    titleOfCategories = [[NSArray alloc] initWithObjects:@"All Categories", nil];
    titleOfCategories = [titleOfCategories arrayByAddingObjectsFromArray:[[OSU_3BSQLiteDatabaseHandler sharedInstance] getCategoriesFromDatabase]];
    
    self.databaseRowPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(0.0, 60.0, 320.0, 197.0)];
    self.databaseRowPicker.dataSource = self;
    self.databaseRowPicker.delegate = self;
    self.databaseRowPicker.rowFont = [UIFont boldSystemFontOfSize:15.0];
    self.databaseRowPicker.rowIndent = 10.0;
    [self.databaseRowPicker reloadData];
    [self.view addSubview:self.databaseRowPicker];
    
    self.categoryPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(0.0, 260.0, 320.0, 197.0)];
    self.categoryPicker.dataSource = self;
    self.categoryPicker.delegate = self;
    self.categoryPicker.rowFont = [UIFont boldSystemFontOfSize:15.0];
    self.categoryPicker.rowIndent = 10.0;
    [self.categoryPicker reloadData];
    [self.view addSubview:self.categoryPicker];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)searchButtonPressed:(UITextField *)sender {

    [self.searchField resignFirstResponder];
    
    OSU_searchResultViewController *resultVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchResultSegue"];

    resultVC.resultBooks = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectBooksFromDatabaseWithKeyword:self.searchField.text
                                                                                                   Category:titleOfCategories[indexOfCategory]
                                                                                                    RowName:titleOfRows[indexOfRow]];
    //[self presentViewController:resultVC animated:YES completion:nil];
    [self.navigationController pushViewController:resultVC animated:YES];

}

- (IBAction) backgroundTap:(id)sender
{
    [self.searchField resignFirstResponder];
}


- (void)Exit
{
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




@end
