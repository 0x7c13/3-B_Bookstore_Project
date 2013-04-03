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

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *PIN;
@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *state;
@property (nonatomic) NSUInteger ZIPCode;
@property (copy, nonatomic) NSString *creditCardType;
@property (copy, nonatomic) NSString *creditCardNumber;


- (OSU_3BUser *)initWithUsername:(NSString *)username
                             PIN:(NSString *)PIN
                       firstName:(NSString *)firstName
                        lastName:(NSString *)lastName
                         address:(NSString *)address
                            city:(NSString *)city
                           state:(NSString *)state
                         ZIPCode:(NSUInteger)ZIPCode
                  creditCardType:(NSString *)creditCardType
                creditCardNumber:(NSString *)creditCardNumber;


@end
