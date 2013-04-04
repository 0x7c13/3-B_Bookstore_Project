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

- (void)insertNewUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType;
- (void)updateUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType;
- (void)deleteUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType;

// return YES if the username exists in the database
- (BOOL)usernameIsExist:(NSString *)username;

@end
