//
//  OSU_3BSQLiteDatabaseHandler.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BSQLiteDatabaseHandler.h"

#define _3BBooksDataBaseFileName @"3BBooks.sqlite"


@interface OSU_3BSQLiteDatabaseHandler()

@property (nonatomic, readwrite) BOOL dataBaseLoadedCorrectly;

@end


@implementation OSU_3BSQLiteDatabaseHandler

// Singleton **************************************************************

+ (id)sharedInstance
{

    static dispatch_once_t p = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}


// init *******************************************************************

- (id)init
{
    if (self = [super init]) {
        
        [self createEditableCopyOfDatabaseIfNeeded];
        
    }
    return self;
}

- (void)createEditableCopyOfDatabaseIfNeeded
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:_3BBooksDataBaseFileName];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if (success) return;
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_3BBooksDataBaseFileName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (void)loadSQLiteDatabase
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths lastObject];
    NSString* databasePath = [documentsDirectory stringByAppendingPathComponent:_3BBooksDataBaseFileName];
    
    if(sqlite3_open([databasePath UTF8String], &_3BBooksDataBase) == SQLITE_OK) {
        NSLog(@"Opened sqlite database at %@", databasePath);
        self.dataBaseLoadedCorrectly = YES;
    } else {
        NSLog(@"Failed to open database at %@ with error %s", databasePath, sqlite3_errmsg(_3BBooksDataBase));
        sqlite3_close (_3BBooksDataBase);
        self.dataBaseLoadedCorrectly = NO;
    }
}

// public methods *********************************************************

- (void)loadDatabase
{
    [self loadSQLiteDatabase];
}

- (void)closeDatabase
{
    sqlite3_close (_3BBooksDataBase);
}

- (OSU_3BBook *)selectABookFromDatabaseWithISBN:(NSString *)ISBNNumber
{
    OSU_3BBook *book;
    NSString *querystring = [NSString stringWithFormat:@"SELECT * FROM Books WHERE ISBN = '%@'", ISBNNumber];
    
    const char *sql = [querystring UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            book = [[OSU_3BBook alloc] initWithISBN:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]
                                              Title:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                                             Author:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                                          Publisher:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                                               Year:(int)sqlite3_column_int(statement, 4)
                                              Price:[[NSString stringWithFormat:@"%.2f",(double)sqlite3_column_double(statement, 5)] doubleValue]
                                           Category:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)]];

        } 
    }
    sqlite3_finalize(statement);
    
    if (!book.ISBN) {
        NSLog(@"Book doesn't exist!");
    }
    return book;
}


- (NSArray *)getCategoriesFromDatabase;
{
    NSMutableArray *categories;
    NSString *querystring = [NSString stringWithFormat:@"SELECT Distinct Category FROM Books"];
    
    const char *sql = [querystring UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        categories = [[NSMutableArray alloc] initWithCapacity:(NSInteger)sqlite3_column_count(statement)];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            [categories addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]];
        }
    }
    sqlite3_finalize(statement);
    
    return (NSArray *)categories;
}


- (OSU_3BBooks *)selectBooksFromDatabaseWithKeyword:(NSString *)keyword
                                          Category:(NSString *)category
                                           RowName:(NSString *)row
{
    OSU_3BBooks *books = [[OSU_3BBooks alloc]init];
    
    NSString *querystring;
    
    NSArray *titleOfRows = [NSArray arrayWithObjects:@"ISBN", @"Title", @"Author", @"Publisher", nil];
    
    if ([row isEqualToString:@"Keyword Anywhere"]) {
        
        querystring = [NSString stringWithFormat:@"SELECT * FROM Books"];
        
        bool controlFlag = YES;
        for (NSString *rowName in titleOfRows) {
            
            if (controlFlag) {
                querystring = [querystring stringByAppendingString:[NSString stringWithFormat:@" WHERE %@ LIKE '%%%@%%'", rowName, keyword]];
                controlFlag = NO;
            }
            else {
                querystring = [querystring stringByAppendingString:[NSString stringWithFormat:@" or %@ LIKE '%%%@%%'", rowName, keyword]];
            }
        }
    }
    else {
        querystring = [NSString stringWithFormat:@"SELECT * FROM Books WHERE %@ LIKE '%%%@%%'", row, keyword];
    }

    if (![category isEqualToString:@"All Categories"]){
        querystring = [querystring stringByAppendingString:[NSString stringWithFormat:@" INTERSECT SELECT * FROM Books WHERE Category = '%@'", category]];
    }
    
    //NSLog(@"%@",querystring);
    
    const char *sql = [querystring UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            OSU_3BBook *book = [[OSU_3BBook alloc] initWithISBN:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]
                                              Title:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                                             Author:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                                          Publisher:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                                               Year:(int)sqlite3_column_int(statement, 4)
                                              Price:[[NSString stringWithFormat:@"%.2f",(double)sqlite3_column_double(statement, 5)] doubleValue]
                                           Category:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)]];

            [books addABook:book];
        }
    }
    sqlite3_finalize(statement);

    return books;
}

@end
