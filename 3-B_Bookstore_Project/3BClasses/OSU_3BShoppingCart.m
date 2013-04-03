//
//  OSU_3BShoppingCart.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BShoppingCart.h"

@interface OSU_3BShoppingCart () {
    double _subtotal;
    NSUInteger _items;
    BOOL _isGuestMode;
}
    
@property (strong, nonatomic) OSU_3BBooks *books;
@property (strong, nonatomic) OSU_3BUser *currentCustomer;

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

- (BOOL)isGuestMode
{
    return _isGuestMode;
}

- (OSU_3BShoppingCart *)init
{
    if (self = [super init]) {
        [self initShoppingCart];
    }
    return self;
}

- (void)initShoppingCart
{
    _books = [[OSU_3BBooks alloc]init];
    _subtotal = 0.0;
    _items = 0;
    _currentCustomer = nil;
    _isGuestMode = YES;
}


- (void)setCurrentCustomer:(OSU_3BUser *)customer
{
    _currentCustomer = customer;
    _isGuestMode = NO;
}

- (OSU_3BUser *)getCurrentCustomer
{
    return _currentCustomer;
}

- (void)addItem:(OSU_3BBook *)book
   withQuantity:(NSUInteger)quantity
{
    
    if (![self isInShoppingCart:book])
    {
        book.Quantity = quantity;
        [self.books addABook:book];
        _subtotal += book.Price * quantity;
        _items += quantity;
    }
}

- (void)changeQuantityOfItem:(OSU_3BBook *)book
                withQuantity:(NSUInteger)quantity
{
    for (int i = 0; i < self.books.count; i++) {
        if ([book isEqual:[self.books objectAtIndexedSubscript:i]]) {
            
            OSU_3BBook *tmpBook = [self.books objectAtIndexedSubscript:i];
            if (quantity > tmpBook.Quantity)
            {
                _subtotal += (quantity - tmpBook.Quantity) * tmpBook.Price;
                _items += (quantity - tmpBook.Quantity);
                [self.books changeQuantityOfItem:book withQuantity:quantity];
            }
            else {
                _subtotal -= (tmpBook.Quantity - quantity) * tmpBook.Price;
                _items -= (tmpBook.Quantity - quantity);
                [self.books changeQuantityOfItem:book withQuantity:quantity];
            }
            break;
        }
    }
}

- (void)removeItem:(OSU_3BBook *)book
{
    for (int i = 0; i < self.books.count; i++) {
        if ([book isEqual:[self.books objectAtIndexedSubscript:i]]) {
            
            OSU_3BBook *tmpBook = [self.books objectAtIndexedSubscript:i];
            _subtotal -= tmpBook.Quantity * tmpBook.Price;
            _items -= tmpBook.Quantity;
            break;
        }
    }
    [self.books removeABook:book];
}

- (double)subtotalValue
{
    if (_subtotal < 0) {
        _subtotal = 0.0;
        return 0.0;
    }
    return _subtotal;
}


- (NSUInteger)numberOfDistinctItemsInShoppingCart
{
    return (NSUInteger)self.books.count;
}

- (NSUInteger)numberOfItemsInShoppingCart
{
    return _items;
}

- (OSU_3BBook *)objectAtIndexedSubscript:(NSUInteger)index
{
    return [self.books objectAtIndexedSubscript:index];
}

- (BOOL)isInShoppingCart:(OSU_3BBook *)book
{
    for (int i = 0; i < self.books.count; i++) {
        if ([book isEqual:[self.books objectAtIndexedSubscript:i]]) {
            return YES;
        }
    }
    return NO;
}

@end
