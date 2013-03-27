//
//  OSU_3BBook.m
//  3-B_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BBook.h"

@implementation OSU_3BBook

- (void)printInformation
{
    NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@\n%@", self.ISBN, self.Titile, self.Author, self.Publisher, self.Year, self.Price, self.Category);

}


@end
