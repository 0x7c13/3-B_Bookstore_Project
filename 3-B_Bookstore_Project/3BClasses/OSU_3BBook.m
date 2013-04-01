//
//  OSU_3BBook.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BBook.h"

@implementation OSU_3BBook

- (id)initWithISBN:(NSString *)ISBN
             Title:(NSString *)Title
            Author:(NSString *)Author
         Publisher:(NSString *)Publisher
              Year:(int)Year
             Price:(double)Price
          Category:(NSString *)Category
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
    }
    return self;
}


- (void)print
{
    NSLog(@"\n%@\n%@\n%@\n%@\n%ld\n%.2f\n%@", self.ISBN, self.Titile, self.Author, self.Publisher, (long)self.Year, self.Price, self.Category);

}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[OSU_3BBook class]]) {
        return [self.ISBN isEqualToString:[(OSU_3BBook *)object ISBN]];
    }
    return NO;
}


@end
