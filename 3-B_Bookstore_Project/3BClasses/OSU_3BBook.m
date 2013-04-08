//
//  OSU_3BBook.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BBook.h"

@interface OSU_3BBook ()

@property (copy, nonatomic, readwrite) NSString *ISBN;
@property (copy, nonatomic, readwrite) NSString *Titile;
@property (copy, nonatomic, readwrite) NSString *Author;
@property (copy, nonatomic, readwrite) NSString *Publisher;
@property (nonatomic, readwrite) NSUInteger Year;
@property (nonatomic, readwrite) double Price;
@property (copy, nonatomic, readwrite) NSString *Category;
@property (nonatomic, readwrite) NSUInteger Quantity;
@property (nonatomic, readwrite) NSUInteger MinQtyRequired;
@property (copy, nonatomic, readwrite) NSString *Reviews;

@end


@implementation OSU_3BBook

- (id)initWithISBN:(NSString *)ISBN
             Title:(NSString *)Title
            Author:(NSString *)Author
         Publisher:(NSString *)Publisher
              Year:(NSUInteger)Year
             Price:(double)Price
          Category:(NSString *)Category
           Reviews:(NSString *)Reviews
    MinQtyRequired:(NSUInteger)MinQtyRequired
{
    if (self = [super init]) {
        
        _ISBN = ISBN;
        _Titile = Title;
        _Author = Author;
        _Publisher = Publisher;
        _Year = Year;
        _Price = Price;
        _Category = Category;
        _Quantity = 0;
        _Reviews = Reviews;
        _MinQtyRequired = MinQtyRequired;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[OSU_3BBook class]]) {
        return [self.ISBN isEqualToString:[(OSU_3BBook *)object ISBN]];
    }
    return NO;
}


@end
