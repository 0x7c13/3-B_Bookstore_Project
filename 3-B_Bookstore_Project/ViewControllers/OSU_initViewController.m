//
//  OSUViewController.m
//  3-B_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_initViewController.h"
#import "OSU_3BSQLiteDatabaseHandler.h"
#import "OSU_3BBook.h"


@interface OSU_initViewController ()

@end

@implementation OSU_initViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // a small test case
    [self databaseHandlerTest];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//************************************



-(void)databaseHandlerTest
{
    OSU_3BSQLiteDatabaseHandler *databaseHandler = [[OSU_3BSQLiteDatabaseHandler alloc] init];
    
    if (databaseHandler.dataBaseLoadedCorrectly) {
        NSLog(@"Good to go!");
        
        OSU_3BBook *book = [databaseHandler selectABookFromDatabaseWithISBN:@"782140661"];
        
        if (book.ISBN) {
            [book printInformation];
        }
    }
    else {
        NSLog(@"Failed to load 3BBooksDatabase!");
    }
}



@end
