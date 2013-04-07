//
//  OSU_3BSQLiteDatabaseHandler.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "OSU_3BBook.h"
#import "OSU_3BBooks.h"
#import "OSU_3BUser.h"
#import "OSU_3BOrder.h"

@interface OSU_3BSQLiteDatabaseHandler : NSObject{

@private sqlite3 *_3BBooksDataBase;
    
}

@property (nonatomic, readonly) BOOL dataBaseLoadedCorrectly;

// Singleton
+ (id)sharedInstance;


// public APIs   
- (void)loadDatabase;
- (void)closeDatabase;
- (NSArray *)getCategoriesFromDatabase;

- (OSU_3BBook *)selectABookFromDatabaseByISBN:(NSString *)ISBNNumber;

- (OSU_3BBooks *)selectBooksFromDatabaseByKeyword:(NSString *)keyword
                                           Category:(NSString *)category
                                            RowName:(NSString *)row;

- (OSU_3BBooks *)selectBooksFromDatabaseBySmartCategory:(NSString *)smartCategory;


- (void)insertNewUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType;
- (void)updateUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType;
- (void)deleteUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType;

- (void)insertNewBook:(OSU_3BBook *)book;
- (void)updateBook:(OSU_3BBook *)book;
- (void)deleteABookByISBN:(NSString *)ISBN;

//- (void)insertAnOrder:(OSU_3BOrder *)order;

- (OSU_3BUser *)selectUserFromDatabaseByUsername:(NSString *)username;

// return YES if the username exists in the database
- (BOOL)usernameIsInDatabase:(NSString *)username;
- (BOOL)bookIsInDatabase:(NSString *)ISBN;

@end
