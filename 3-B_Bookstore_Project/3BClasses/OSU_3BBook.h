//
//  OSU_3BBook.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSU_3BBook : NSObject

@property (copy, nonatomic) NSString *ISBN;
@property (copy, nonatomic) NSString *Titile;
@property (copy, nonatomic) NSString *Author;
@property (copy, nonatomic) NSString *Publisher;
@property (nonatomic) NSUInteger Year;
@property (nonatomic) double Price;
@property (copy, nonatomic) NSString *Category;
@property (nonatomic) NSUInteger Quantity;
@property (nonatomic) NSUInteger MinQtyRequired;
@property (copy, nonatomic) NSString *Reviews;

// custom setter
- (id)initWithISBN:(NSString *)ISBN
             Title:(NSString *)Title
            Author:(NSString *)Author
         Publisher:(NSString *)Publisher
              Year:(NSUInteger)Year
             Price:(double)Price
          Category:(NSString *)Category
           Reviews:(NSString *)Reviews
    MinQtyRequired:(NSUInteger)MinQtyRequired;


- (BOOL)isEqual:(id)object;

@end
