//
//  OSU_3BShoppingCart.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BShoppingCart.h"

@interface OSU_3BShoppingCart ()
    
@property (strong, nonatomic) OSU_3BBooks *books;

@end


@implementation OSU_3BShoppingCart

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

- (OSU_3BShoppingCart *)init
{
    if (self = [super init]) {
        [self initShoppingCart];
    }
    return self;
}


- (void)addItem:(OSU_3BBook *)book
   withQuantity:(NSUInteger)quantity
{
    book.Quantity = quantity;
    [self.books addABook:book];
}

- (void)initShoppingCart
{
    _books = [[OSU_3BBooks alloc]init];
}


- (NSUInteger)numberOfDistinctItemsInShoppingCart
{
    return self.books.count;
}

- (BOOL)isInShoppingCart:(OSU_3BBook *)book
{
    for (int i = 0; i < self.books.count; i++) {
        if ([book.ISBN isEqualToString:[self.books objectAtIndexedSubscript:i].ISBN]) {
            return YES;
        }
    }
    return NO;
}

@end
