//
//  OSU_3BOrder.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BOrder.h"

@interface OSU_3BOrder ()

@property (copy, nonatomic, readwrite) NSString *ISBN;
@property (copy, nonatomic, readwrite) NSString *Username;
@property (copy, nonatomic, readwrite) NSString *Date;
@property (copy, nonatomic, readwrite) NSString *Time;
@property (nonatomic, readwrite) NSUInteger Quantity;

@end
@implementation OSU_3BOrder


- (id)initWithISBN:(NSString *)ISBN
          Username:(NSString *)Username
              Date:(NSString *)Date
              Time:(NSString *)Time
      withQuantity:(NSUInteger)Quantity
{
    if (self = [super init]) {
    
        _ISBN = ISBN;
        _Username = Username;
        _Date = Date;
        _Time = Time;
        _Quantity = Quantity;
    }
    
    return self;
}

@end
