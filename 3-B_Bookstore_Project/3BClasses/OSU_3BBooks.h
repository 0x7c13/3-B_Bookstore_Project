//
//  OSU_3BBooks.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSU_3BBook.h"

@interface OSU_3BBooks : NSObject

- (NSUInteger)count;
- (void)addABook:(OSU_3BBook *)book;
- (void)removeABook:(OSU_3BBook *)book;
- (void)changeQuantityOfItem:(OSU_3BBook *)book
                withQuantity:(NSUInteger)quantity;
- (OSU_3BBook *)objectAtIndexedSubscript:(NSUInteger)bookNumber;

@end
