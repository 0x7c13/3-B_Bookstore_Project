//
//  OSU_3BShoppingCart.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-30.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSU_3BBook.h"
#import "OSU_3BBooks.h"

@interface OSU_3BShoppingCart : NSObject



+ (id)sharedInstance;

- (void)setUsernameOfTheCurrentCustomer:(NSString *)username;
- (NSString *)getUsernameOfTheCurrentCustomer;
- (BOOL)isGuestMode;

- (void)initShoppingCart;

- (void)addItem:(OSU_3BBook *)book
   withQuantity:(NSUInteger)quantity;
- (void)removeItem:(OSU_3BBook *)book;
- (void)changeQuantityOfItem:(OSU_3BBook *)book
                withQuantity:(NSUInteger)quantity;

- (double)subtotalValue;

- (NSUInteger)numberOfDistinctItemsInShoppingCart;

- (OSU_3BBook *)objectAtIndexedSubscript:(NSUInteger)index;

- (BOOL)isInShoppingCart:(OSU_3BBook *)book;

@end
