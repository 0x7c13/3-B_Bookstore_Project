//
//  OSU_3BUser.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-1.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BUser.h"

@interface OSU_3BUser()

@property (copy, nonatomic, readwrite) NSString *username;
@property (copy, nonatomic, readwrite) NSString *PIN;
@property (copy, nonatomic, readwrite) NSString *firstName;
@property (copy, nonatomic, readwrite) NSString *lastName;
@property (copy, nonatomic, readwrite) NSString *address;
@property (copy, nonatomic, readwrite) NSString *city;
@property (copy, nonatomic, readwrite) NSString *state;
@property (nonatomic, readwrite) NSUInteger ZIPCode;
@property (copy, nonatomic, readwrite) NSString *creditCardType;
@property (copy, nonatomic, readwrite) NSString *creditCardNumber;
@property (copy, nonatomic, readwrite) NSString *creditCardExpirationDate;

@end

@implementation OSU_3BUser


- (id)initWithUsername:(NSString *)username
                             PIN:(NSString *)PIN
                       firstName:(NSString *)firstName
                        lastName:(NSString *)lastName
                         address:(NSString *)address
                            city:(NSString *)city
                           state:(NSString *)state
                         ZIPCode:(NSUInteger)ZIPCode
                  creditCardType:(NSString *)creditCardType
                creditCardNumber:(NSString *)creditCardNumber
        creditCardExpirationDate:(NSString *)expirationDate
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
        _creditCardExpirationDate = expirationDate;
        _smartCategory = @"";
        _isReturingCustomer = NO;
    }
    
    return  self;
}

@end
