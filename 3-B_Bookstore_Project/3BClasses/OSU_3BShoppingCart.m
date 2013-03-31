//
//  OSU_3BShoppingCart.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BShoppingCart.h"

@interface OSU_3BShoppingCart () {
    double _subtotal;
}
    
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
    
    if (![self isInShoppingCart:book])
    {
        book.Quantity = quantity;
        [self.books addABook:book];
        _subtotal += book.Price * quantity;
    }
}

- (void)changeQuantityOfItem:(OSU_3BBook *)book
                withQuantity:(NSUInteger)quantity
{
    for (int i = 0; i < self.books.count; i++) {
        if ([book.ISBN isEqualToString:[self.books objectAtIndexedSubscript:i].ISBN]) {
            
            OSU_3BBook *tmpBook = [self.books objectAtIndexedSubscript:i];
            if (quantity > tmpBook.Quantity)
            {
                _subtotal += (quantity - tmpBook.Quantity) * tmpBook.Price;
                [self.books changeQuantityOfItem:book withQuantity:quantity];
            }
            else {
                _subtotal -= (tmpBook.Quantity - quantity) * tmpBook.Price;
                [self.books changeQuantityOfItem:book withQuantity:quantity];
            }
            break;
        }
    }
}

- (void)removeItem:(OSU_3BBook *)book
{
    for (int i = 0; i < self.books.count; i++) {
        if ([book.ISBN isEqualToString:[self.books objectAtIndexedSubscript:i].ISBN]) {
            
            OSU_3BBook *tmpBook = [self.books objectAtIndexedSubscript:i];
            _subtotal -= tmpBook.Quantity * tmpBook.Price;
            break;
        }
    }
    [self.books removeABook:book];
}

- (double)subtotalValue
{
    if (_subtotal < 0) return 0.0;
    return _subtotal;
}

- (void)initShoppingCart
{
    _books = [[OSU_3BBooks alloc]init];
    _subtotal = 0.0;
}


- (NSUInteger)numberOfDistinctItemsInShoppingCart
{
    return (NSUInteger)self.books.count;
}

- (OSU_3BBook *)objectAtIndexedSubscript:(NSUInteger)index
{
    return [self.books objectAtIndexedSubscript:index];
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
