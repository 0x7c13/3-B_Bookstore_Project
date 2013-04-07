//
//  OSU_3BOrder.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSU_3BOrder : NSObject

@property (copy, nonatomic) NSString *ISBN;
@property (copy, nonatomic) NSString *Username;
@property (copy, nonatomic) NSString *Date;
@property (copy, nonatomic) NSString *Time;
@property (nonatomic) NSUInteger Quantity;


// default custom setter
- (id)initWithISBN:(NSString *)ISBN
          Username:(NSString *)Username
              Date:(NSString *)Date
              Time:(NSString *)Time
      withQuantity:(NSUInteger)Quantity;

@end
