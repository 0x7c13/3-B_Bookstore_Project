//
//  OSU_3BUser.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-1.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSU_3BUser : NSObject

typedef enum {
	
    OSU_3BUserTypeCustomer,
    
    OSU_3BUserTypeAdministrator
    
} OSU_3BUserUserTypes;

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *PIN;
@property (copy, nonatomic, readonly) NSString *firstName;
@property (copy, nonatomic, readonly) NSString *lastName;
@property (copy, nonatomic, readonly) NSString *address;
@property (copy, nonatomic, readonly) NSString *city;
@property (copy, nonatomic, readonly) NSString *state;
@property (nonatomic, readonly) NSUInteger ZIPCode;
@property (copy, nonatomic, readonly) NSString *creditCardType;
@property (copy, nonatomic, readonly) NSString *creditCardNumber;
@property (copy, nonatomic, readonly) NSString *creditCardExpirationDate;

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
        creditCardExpirationDate:(NSString *)expirationDate;


@end
