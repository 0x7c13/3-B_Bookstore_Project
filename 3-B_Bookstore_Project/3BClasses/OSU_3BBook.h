//
//  OSU_3BBook.h
//  3-B_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSU_3BBook : NSObject

@property (strong, nonatomic) NSString *ISBN;
@property (strong, nonatomic) NSString *Titile;
@property (strong, nonatomic) NSString *Author;
@property (strong, nonatomic) NSString *Publisher;
@property (strong, nonatomic) NSNumber *Year;
@property (strong, nonatomic) NSNumber *Price;
@property (strong, nonatomic) NSString *Category;


- (void)printInformation;

@end
