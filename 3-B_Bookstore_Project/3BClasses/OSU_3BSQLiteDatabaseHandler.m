//
//  OSU_3BSQLiteDatabaseHandler.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
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
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM Books WHERE ISBN = '%@'", ISBNNumber];
    
    const char *sql = [queryString UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSString *reviews;
            if (!(char*)sqlite3_column_text(statement, 7)) {
                reviews = @"";
            }
            else {
                reviews = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
            }
            
            book = [[OSU_3BBook alloc] initWithISBN:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]
                                              Title:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                                             Author:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                                          Publisher:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                                               Year:(NSUInteger)sqlite3_column_int(statement, 4)
                                              Price:[[NSString stringWithFormat:@"%.2f",(double)sqlite3_column_double(statement, 5)] doubleValue]
                                           Category:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)]
                                            Reviews:reviews
                                     MinQtyRequired:(NSUInteger)sqlite3_column_int(statement, 8)];
                            
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
    NSString *queryString = [NSString stringWithFormat:@"SELECT Distinct Category FROM Books"];
    
    const char *sql = [queryString UTF8String];
    
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
    
    NSString *queryString;
    
    NSArray *titleOfRows = @[@"ISBN", @"Title", @"Author", @"Publisher"];
    
    if ([row isEqualToString:@"Keyword Anywhere"]) {
        
        queryString = [NSString stringWithFormat:@"SELECT * FROM Books"];
        
        bool controlFlag = YES;
        for (NSString *rowName in titleOfRows) {
            
            if (controlFlag) {
                queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@" WHERE %@ LIKE '%%%@%%'", rowName, keyword]];
                controlFlag = NO;
            }
            else {
                queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@" or %@ LIKE '%%%@%%'", rowName, keyword]];
            }
        }
    }
    else {
        queryString = [NSString stringWithFormat:@"SELECT * FROM Books WHERE %@ LIKE '%%%@%%'", row, keyword];
    }

    if (![category isEqualToString:@"All Categories"]){
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@" INTERSECT SELECT * FROM Books WHERE Category = '%@'", category]];
    }
    
    //NSLog(@"%@",queryString);
    
    const char *sql = [queryString UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {

        while (sqlite3_step(statement) == SQLITE_ROW) {
            
    
            NSString *reviews;
            if (!(char*)sqlite3_column_text(statement, 7)) {
                reviews = @"";
            }
            else {
                reviews = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
            }
            
            OSU_3BBook *book = [[OSU_3BBook alloc] initWithISBN:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]
                                              Title:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                                             Author:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                                          Publisher:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                                               Year:(NSUInteger)sqlite3_column_int(statement, 4)
                                              Price:[[NSString stringWithFormat:@"%.2f",(double)sqlite3_column_double(statement, 5)] doubleValue]
                                           Category:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)]
                                            Reviews:reviews
                                     MinQtyRequired:(NSUInteger)sqlite3_column_int(statement, 8)];

            [books addABook:book];
        }
    }
    sqlite3_finalize(statement);

    return books;
}

- (BOOL)usernameIsInDatabase:(NSString *)username
{
    BOOL result = NO;
    
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM Customers WHERE Username = '%@'", username];
    
    const char *sql = [queryString UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            result = YES;
        }
    }
    sqlite3_finalize(statement);
    
    return result;
}

- (BOOL)bookIsInDatabase:(NSString *)ISBN
{
    BOOL result = NO;
    
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM Books WHERE ISBN = '%@'", ISBN];
    
    const char *sql = [queryString UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            result = YES;
        }
    }
    sqlite3_finalize(statement);
    
    return result;
}


- (void)insertNewUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType
{
    if (userType == OSU_3BUserTypeCustomer) {
        
        static sqlite3_stmt *insertStmt = nil;
        
        if(insertStmt == nil)
        {
            const char *sql = [@"INSERT INTO Customers (Username, PIN, FirstName, LastName, Address, City, State, ZIP, CreditCardType, CreditCardNumber, CreditCardExpirationDate) VALUES(?,?,?,?,?,?,?,?,?,?,?)" UTF8String];
            
            if(sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &insertStmt, NULL) != SQLITE_OK)
                NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(_3BBooksDataBase));
        }
        
        sqlite3_bind_text(insertStmt, 1, [user.username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 2, [user.PIN UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 3, [user.firstName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 4, [user.lastName UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 5, [user.address UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 6, [user.city UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 7, [user.state UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int (insertStmt, 8, (int)user.ZIPCode);
        sqlite3_bind_text(insertStmt, 9, [user.creditCardType UTF8String], -1, SQLITE_TRANSIENT);;
        sqlite3_bind_text(insertStmt, 10, [user.creditCardNumber UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 11, [user.creditCardExpirationDate UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(insertStmt))
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(_3BBooksDataBase));
        else
            NSLog(@"New User Inserted.");

        sqlite3_finalize(insertStmt);
        insertStmt = nil;
    }
}

-(void)updateUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType
{
    [self deleteUser:user withUserType:userType];
    
    [self insertNewUser:user withUserType:userType];
}

- (void)updateBook:(OSU_3BBook *)book
{
    [self deleteABookByISBN:book.ISBN];
    
    [self insertNewBook:book];
}

- (void)deleteUser:(OSU_3BUser *)user withUserType:(OSU_3BUserUserTypes)userType
{    
    sqlite3_stmt* statement;
    
    // Create Query String.
    NSString* sqlStatement = [NSString stringWithFormat:@"DELETE FROM Customers WHERE Username ='%@'", user.username];
    
    if( sqlite3_prepare_v2(_3BBooksDataBase, [sqlStatement UTF8String], -1, &statement, NULL) == SQLITE_OK )
    {
        if( sqlite3_step(statement) == SQLITE_DONE )
        {
            NSLog( @"User with username: \"%@\" was deleted.", user.username );
        }
        else
        {
            NSLog( @"DeleteFromDataBase: Failed from sqlite3_step. Error is:  %s", sqlite3_errmsg(_3BBooksDataBase) );
        }
    }
    else
    {
        NSLog( @"DeleteFromDataBase: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(_3BBooksDataBase) );
    }
    
    // Finalize and close database.
    sqlite3_finalize(statement);
}

- (void)deleteABookByISBN:(NSString *)ISBN
{
    sqlite3_stmt* statement;
    
    // Create Query String.
    NSString* sqlStatement = [NSString stringWithFormat:@"DELETE FROM Books WHERE ISBN ='%@'", ISBN];
    
    if( sqlite3_prepare_v2(_3BBooksDataBase, [sqlStatement UTF8String], -1, &statement, NULL) == SQLITE_OK )
    {
        if( sqlite3_step(statement) == SQLITE_DONE )
        {
            NSLog( @"Book with ISBN: \"%@\" was deleted.", ISBN);
        }
        else
        {
            NSLog( @"DeleteFromDataBase: Failed from sqlite3_step. Error is:  %s", sqlite3_errmsg(_3BBooksDataBase) );
        }
    }
    else
    {
        NSLog( @"DeleteFromDataBase: Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(_3BBooksDataBase) );
    }
    
    // Finalize and close database.
    sqlite3_finalize(statement);

}



-(OSU_3BUser *)selectUserFromDatabaseByUsername:(NSString *)username
{
    OSU_3BUser *user;
    
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM Customers WHERE Username = '%@'", username];
    
    const char *sql = [queryString UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &statement, NULL)!=SQLITE_OK){
        
        NSLog(@"sql problem occured with: %s", sql);
        NSLog(@"%s", sqlite3_errmsg(_3BBooksDataBase));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            user = [[OSU_3BUser alloc] initWithUsername:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]
                                                    PIN:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)]
                                              firstName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)]
                                               lastName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)]
                                                address:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)]
                                                   city:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)]
                                                  state:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)]
                                                ZIPCode:(NSUInteger)sqlite3_column_int(statement, 7)
                                         creditCardType:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)]
                                       creditCardNumber:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)]
                               creditCardExpirationDate:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]];
            
        }
    }
    sqlite3_finalize(statement);
    
    return user;
}


-(void)insertNewBook:(OSU_3BBook *)book
{
    static sqlite3_stmt *insertStmt = nil;
    
    if(insertStmt == nil)
    {
        const char *sql = [@"INSERT INTO Books (ISBN, Title, Author, Publisher, Year, Price, Category, Reviews, MinQtyRequired) VALUES(?,?,?,?,?,?,?,?,?)" UTF8String];
        
        if(sqlite3_prepare_v2(_3BBooksDataBase, sql, -1, &insertStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(_3BBooksDataBase));
    }
    
    sqlite3_bind_text(insertStmt, 1, [book.ISBN UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStmt, 2, [book.Titile UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStmt, 3, [book.Author UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStmt, 4, [book.Publisher UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int (insertStmt, 5, (int)book.Year);
    sqlite3_bind_double(insertStmt, 6, (double)book.Price);
    sqlite3_bind_text(insertStmt, 7, [book.Category UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStmt, 8, [book.Reviews UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int (insertStmt, 9, (int)book.MinQtyRequired);
    
    if(SQLITE_DONE != sqlite3_step(insertStmt))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(_3BBooksDataBase));
    else
        NSLog(@"New Book Inserted.");
    
    sqlite3_finalize(insertStmt);
    insertStmt = nil;
    
}
@end
