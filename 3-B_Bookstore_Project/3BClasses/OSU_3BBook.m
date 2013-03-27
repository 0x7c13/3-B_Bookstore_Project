//
//  OSU_3BBook.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BBook.h"

@implementation OSU_3BBook

- (void)printInformation
{
    NSLog(@"\n%@\n%@\n%@\n%@\n%ld\n%.2f\n%@", self.ISBN, self.Titile, self.Author, self.Publisher, (long)self.Year, self.Price, self.Category);

}


@end
