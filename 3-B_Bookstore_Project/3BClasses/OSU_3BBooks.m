//
//  OSU_3BBooks.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BBooks.h"

@interface OSU_3BBooks ()

@property (strong, nonatomic) NSMutableArray *listOfBooks;

@end

@implementation OSU_3BBooks

- (NSMutableArray *)listOfBooks
{
    if (!_listOfBooks){
        _listOfBooks = [[NSMutableArray alloc] init];
    }
    return _listOfBooks;
}

- (id)initWithBooks:(NSMutableArray *)arrayOfBooks
{
    if (self = [super init]){
        _listOfBooks = arrayOfBooks;
    }
    return self;
}

- (void)addABook:(OSU_3BBook *)book
{
    [self.listOfBooks addObject:book];
}

- (NSUInteger)count
{
    return self.listOfBooks.count;
}

- (OSU_3BBook *)objectAtIndexedSubscript:(NSUInteger)bookNumber
{
    return [self.listOfBooks objectAtIndex:bookNumber];

}

@end
