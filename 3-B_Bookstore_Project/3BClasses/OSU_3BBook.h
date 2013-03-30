//
//  OSU_3BBook.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSU_3BBook : NSObject

@property (copy, nonatomic) NSString *ISBN;
@property (copy, nonatomic) NSString *Titile;
@property (copy, nonatomic) NSString *Author;
@property (copy, nonatomic) NSString *Publisher;
@property (nonatomic) NSInteger Year;
@property (nonatomic) double Price;
@property (copy, nonatomic) NSString *Category;
@property (nonatomic) NSUInteger Quantity;

// custom setter
- (id)initWithISBN:(NSString *)ISBN
             Title:(NSString *)Title
            Author:(NSString *)Author
         Publisher:(NSString *)Publisher
              Year:(int)Year
             Price:(double)Price
          Category:(NSString *)Category;

- (void)print;

@end
