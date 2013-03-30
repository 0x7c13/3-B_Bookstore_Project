//
//  OSU_3BSQLiteDatabaseHandler.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "OSU_3BBook.h"
#import "OSU_3BBooks.h"

@interface OSU_3BSQLiteDatabaseHandler : NSObject{
    sqlite3 *_3BBooksDataBase;
}

@property (nonatomic, readonly) BOOL dataBaseLoadedCorrectly;

// Singleton
+ (id)sharedInstance;


// public methods   
- (void)loadDatabase;
- (void)closeDatabase;
- (NSArray *)getCategoriesFromDatabase;

- (OSU_3BBook *)selectABookFromDatabaseWithISBN:(NSString *)ISBNNumber;

- (OSU_3BBooks *)selectBooksFromDatabaseWithKeyword:(NSString *)keyword
                                           Category:(NSString *)category
                                            RowName:(NSString *)row;


@end
