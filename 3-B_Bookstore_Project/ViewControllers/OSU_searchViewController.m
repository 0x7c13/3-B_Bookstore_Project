//
//  OSU_searchViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_searchViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"

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
}

- (void)addPickers;
{
    titleOfRows = [NSArray arrayWithObjects:@"Keyword Anywhere", @"ISBN", @"Titile", @"Author", @"Publisher", nil];
    
    titleOfCategories = [[OSU_3BSQLiteDatabaseHandler sharedInstance] getCategoriesFromDatabase];
    
    self.databaseRowPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(30.0, 70.0, 196.0, 197.0)];
    self.databaseRowPicker.dataSource = self;
    self.databaseRowPicker.delegate = self;
    self.databaseRowPicker.rowFont = [UIFont boldSystemFontOfSize:15.0];
    self.databaseRowPicker.rowIndent = 10.0;
    [self.databaseRowPicker reloadData];
    [self.view addSubview:self.databaseRowPicker];
    
    self.categoryPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(30.0, 290.0, 196.0, 197.0)];
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




- (IBAction)exitButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)searchButtonPressed:(UITextField *)sender {
    
    NSLog(@"%@", self.searchField.text);
    
    NSLog(@"%@", titleOfRows[indexOfRow]);
    
    if (indexOfCategory == 0) {
        NSLog(@"All Categories");
    }
    else {
        NSLog(@"%@", titleOfCategories[indexOfCategory - 1]);
    }
    
}

- (IBAction) backgroundTap:(id)sender
{
    [self.searchField resignFirstResponder];
}


// protocols ********************


#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (pickerView == self.databaseRowPicker)
        return titleOfRows.count;
    else {
        return titleOfCategories.count + 1;
    }
}




- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == self.databaseRowPicker)
        return [titleOfRows objectAtIndex:row];
    else {
        if (row == 0) return @"All Categories";
        else return [titleOfCategories objectAtIndex:row - 1];
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