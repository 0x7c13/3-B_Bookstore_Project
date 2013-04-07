//
//  OSU_3BOrder.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BOrder.h"

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
