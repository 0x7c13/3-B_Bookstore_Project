//
//  OSU_3BBook.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSU_3BBook : NSObject

@property (copy, nonatomic, readonly) NSString *ISBN;
@property (copy, nonatomic, readonly) NSString *Titile;
@property (copy, nonatomic, readonly) NSString *Author;
@property (copy, nonatomic, readonly) NSString *Publisher;
@property (nonatomic, readonly) NSUInteger Year;
@property (nonatomic, readonly) double Price;
@property (copy, nonatomic, readonly) NSString *Category;
@property (nonatomic, readonly) NSUInteger Quantity;
@property (nonatomic, readonly) NSUInteger MinQtyRequired;
@property (copy, nonatomic, readonly) NSString *Reviews;

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
- (void)setQuantity:(NSUInteger)Quantity;

@end
