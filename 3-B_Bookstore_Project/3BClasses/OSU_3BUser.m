//
//  OSU_3BUser.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-1.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BUser.h"

@implementation OSU_3BUser


- (OSU_3BUser *)initWithUsername:(NSString *)username
                             PIN:(NSString *)PIN
                       firstName:(NSString *)firstName
                        lastName:(NSString *)lastName
                         address:(NSString *)address
                            city:(NSString *)city
                           state:(NSString *)state
                         ZIPCode:(NSUInteger)ZIPCode
                  creditCardType:(NSString *)creditCardType
                creditCardNumber:(NSString *)creditCardNumber
{

    if (self = [super init]) {
        _username = username;
        _PIN = PIN;
        _firstName = firstName;
        _lastName = lastName;
        _address = address;
        _city = city;
        _state = state;
        _ZIPCode = ZIPCode;
        _creditCardType = creditCardType;
        _creditCardNumber = creditCardNumber;
    }
    
    return  self;
}

@end
