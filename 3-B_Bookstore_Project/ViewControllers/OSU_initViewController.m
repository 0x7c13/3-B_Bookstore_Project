//
//  OSUViewController.m
//  3-B_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_initViewController.h"
#import "OSU_searchViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_3BBook.h"
#import "OSU_3BShoppingCart.h"


@interface OSU_initViewController ()

@end

@implementation OSU_initViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // a small test case
    //[self databaseHandlerTest];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************


-(void)databaseHandlerTest
{
    OSU_3BSQLiteDatabaseHandler *databaseHandler = [OSU_3BSQLiteDatabaseHandler sharedInstance];
    
    if (databaseHandler.dataBaseLoadedCorrectly) {
        NSLog(@"Good to go!");
        
        OSU_3BBook *book = [databaseHandler selectABookFromDatabaseWithISBN:@"451209532"];
        
        if (book.ISBN) {
            [book print];
        }
    }
    else {
        NSLog(@"Failed to load 3BBooksDatabase!");
    }
    
    OSU_3BBooks *books = [[OSU_3BSQLiteDatabaseHandler sharedInstance] selectBooksFromDatabaseWithKeyword:@"SQL" Category:@"All Categories" RowName:@"Title"];
    
    for (int i = 0; i < books.count; i++) {
        [[books objectAtIndexedSubscript:i] print];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OSU_searchViewController *searchVC = segue.destinationViewController;
    
    searchVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (IBAction)searchOnlyButtonPressed:(UIButton *)sender {
    
    [[OSU_3BShoppingCart sharedInstance] initShoppingCart];
    
}


@end
